function ws {
    param(
        # Shell to start on the workstation; empty string = default login shell
        [string]$Shell = "/home/user/.local/share/mise/installs/aqua-fish-shell-fish-shell/latest/fish"
    )

    $p = @{
        project = "p-2005472-ceu-ops-0000"
        region  = "europe-west3"
        cluster = "ws-cluster-p-crzvdidevelop"
        config  = "ws-code-oss-fullstack-client-config-2"
        ws      = "xn94668-fcc-2"
        port    = 2222
        user    = "user"                        # check with 'whoami' on the workstation
        key     = "$HOME\.ssh\id_ed25519"       # private key
    }
    $common = "--project=$($p.project)", "--region=$($p.region)",
              "--cluster=$($p.cluster)", "--config=$($p.config)"

    # 0. Check that the SSH key exists
    if (-not (Test-Path $p.key)) {
        Write-Error "SSH key '$($p.key)' not found. Create it with: ssh-keygen -t ed25519"
        return
    }

    # 1. Authentication: log in only if no valid token exists
    gcloud auth print-access-token *> $null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "No valid gcloud credentials - starting login..." -ForegroundColor Yellow
        gcloud auth login
        if ($LASTEXITCODE -ne 0) {
            Write-Error "gcloud authentication failed."
            return
        }
    }

    # 2. Start the workstation (does nothing if it is already running)
    Write-Host "Starting workstation (if needed)..." -ForegroundColor Cyan
    gcloud workstations start $p.ws @common 2>$null

    # 3. Open the tunnel in the background
    $job = Start-Job -ArgumentList $p.ws, $common, $p.port -ScriptBlock {
        param($ws, $common, $port)
        gcloud workstations start-tcp-tunnel $ws 22 @common --local-host-port="localhost:$port"
    }

    # Wait until the tunnel port answers (max. 30 s)
    $ready = $false
    for ($i = 0; $i -lt 30 -and -not $ready; $i++) {
        try {
            $tcp = [System.Net.Sockets.TcpClient]::new("localhost", $p.port)
            $tcp.Close(); $ready = $true
        } catch { Start-Sleep -Seconds 1 }
    }
    if (-not $ready) {
        Write-Error "Tunnel could not be opened."
        Receive-Job $job; Remove-Job $job -Force
        return
    }

    # 4. Connect over SSH (settings inline, no ~/.ssh/config needed)
    $sshArgs = @(
        "-p", $p.port,
        "-i", $p.key,
        "-o", "StrictHostKeyChecking=no",
        "-o", "UserKnownHostsFile=NUL",
        "-o", "LogLevel=ERROR",
        "-o", "ServerAliveInterval=30"
    )

    if ($Shell) {
        # -t = interactive terminal; falls back to bash if the shell is missing
        $sshArgs += "-t", "$($p.user)@localhost",
                    "if [ -x $Shell ]; then exec $Shell -l; else echo 'Shell not found, using bash'; exec bash -l; fi"
    } else {
        $sshArgs += "$($p.user)@localhost"
    }

    try     { ssh @sshArgs }
    finally { Stop-Job $job; Remove-Job $job }
}


function wst {
    $p = @{
        project = "p-2005472-ceu-ops-0000"
        region  = "europe-west3"
        cluster = "ws-cluster-p-crzvdidevelop"
        config  = "ws-code-oss-fullstack-client-config-2"
        ws      = "xn94668-fcc-2"
        port    = 8880
    }
    $common = "--project=$($p.project)", "--region=$($p.region)",
              "--cluster=$($p.cluster)", "--config=$($p.config)"

    # 1. Authentication: log in only if no valid token exists
    gcloud auth print-access-token *> $null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "No valid gcloud credentials - starting login..." -ForegroundColor Yellow
        gcloud auth login
        if ($LASTEXITCODE -ne 0) { Write-Error "gcloud authentication failed."; return }
    }

    # 2. Start the workstation (waits until running; does nothing if already running)
    Write-Host "Starting workstation (if needed)..." -ForegroundColor Cyan
    gcloud workstations start $p.ws @common 2>$null

    # 3. Run the tunnel in the foreground (Ctrl+C to stop)
    Write-Host "Forwarding port 22 -> localhost:$($p.port) (Ctrl+C to stop)" -ForegroundColor Green
    gcloud workstations start-tcp-tunnel $p.ws 22 @common --local-host-port="localhost:$($p.port)"
}
