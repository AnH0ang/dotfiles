set -gx PATH /home/user/.vscode-server/data/User/globalStorage/github.copilot-chat/debugCommand /home/user/.vscode-server/data/User/globalStorage/github.copilot-chat/copilotCli /home/user/.vscode-server/cli/servers/Stable-c2d1b13fdc4a77628e5f3bb70173351c8f2fbad1/server/bin/remote-cli /home/user/.local/bin /home/user/.local/share/pnpm/bin /home/user/.local/bin /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/games /usr/local/games /snap/bin /usr/local/go/bin /home/user/.vscode-server/extensions/ms-python.debugpy-2026.6.0/bundled/scripts/noConfigScripts
if functions -q __mise_clear_completions; __mise_clear_completions; functions -e __mise_clear_completions; end
functions --erase __mise_env_eval
functions --erase __mise_env_eval_on_prompt
functions --erase __mise_env_eval_2
functions --erase __mise_cd_hook
functions --erase mise
set -e __mise_skip_first_prompt_pwd
set -e MISE_SHELL
set -e __MISE_DIFF
set -e __MISE_SESSION
set -gx PATH /home/user/.local/share/mise/shims /home/user/.vscode-server/data/User/globalStorage/github.copilot-chat/debugCommand /home/user/.vscode-server/data/User/globalStorage/github.copilot-chat/copilotCli /home/user/.vscode-server/cli/servers/Stable-c2d1b13fdc4a77628e5f3bb70173351c8f2fbad1/server/bin/remote-cli /home/user/.local/bin /home/user/.local/share/pnpm/bin /home/user/.local/bin /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/games /usr/local/games /snap/bin /usr/local/go/bin /home/user/.vscode-server/extensions/ms-python.debugpy-2026.6.0/bundled/scripts/noConfigScripts
set -gx MISE_SHELL fish
if not set -q __MISE_ORIG_PATH
    set -gx __MISE_ORIG_PATH $PATH
end

function mise
  if test (count $argv) -eq 0
    command /home/user/.local/bin/mise
    return
  end

  set command $argv[1]
  set -e argv[1]

  if contains -- --help $argv
    command /home/user/.local/bin/mise "$command" $argv
    return $status
  end

  switch "$command"
  case deactivate shell sh
    # if help is requested, don't eval
    if contains -- -h $argv
      command /home/user/.local/bin/mise "$command" $argv
    else if contains -- --help $argv
      command /home/user/.local/bin/mise "$command" $argv
    else
      source (command /home/user/.local/bin/mise "$command" $argv |psub)
    end
  case '*'
    command /home/user/.local/bin/mise "$command" $argv
  end
end

function __mise_env_eval --description 'Update mise environment when changing directories';
    /home/user/.local/bin/mise hook-env --shell-pid $fish_pid -s fish $argv | source;

    if test "$mise_fish_mode" != "disable_arrow";
        function __mise_cd_hook --on-variable PWD --description 'Update mise environment when changing directories';
            if test "$mise_fish_mode" = "eval_after_arrow";
                set -g __mise_env_again 0;
            else;
                /home/user/.local/bin/mise hook-env --shell-pid $fish_pid -s fish | source;
            end;
        end;
    end;
end;

function __mise_env_eval_on_prompt --on-event fish_prompt --description 'Update mise environment when changing directories';
    if set -q __mise_skip_first_prompt_pwd;
        set -l activate_pwd "$__mise_skip_first_prompt_pwd";
        set -e __mise_skip_first_prompt_pwd;
        if test "$PWD" = "$activate_pwd";
            return;
        end;
    end;

    __mise_env_eval;
end;

function __mise_env_eval_2 --on-event fish_preexec --description 'Update mise environment when changing directories';
    if set -q __mise_env_again;
        set -e __mise_env_again;
        /home/user/.local/bin/mise hook-env --shell-pid $fish_pid -s fish | source;
        echo;
    end;

    if test "$mise_fish_mode" = "eval_after_arrow";
        functions --erase __mise_cd_hook;
    end;
end;

__mise_env_eval --force
set -g __mise_skip_first_prompt_pwd "$PWD"
if functions -q fish_command_not_found; and not functions -q __mise_fish_command_not_found
    functions -e __mise_fish_command_not_found
    functions -c fish_command_not_found __mise_fish_command_not_found
end

function fish_command_not_found
    if string match -qrv -- '^(?:mise$|mise-)' $argv[1] &&
        /home/user/.local/bin/mise hook-not-found -s fish -- $argv[1]
        /home/user/.local/bin/mise hook-env --shell-pid $fish_pid -s fish | source
    else if functions -q __mise_fish_command_not_found
        __mise_fish_command_not_found $argv
    else
        __fish_default_command_not_found_handler $argv
    end
end
