function _kedro_completion
    set -l response (env _KEDRO_COMPLETE=fish_complete COMP_WORDS=(commandline -cp) COMP_CWORD=(commandline -t) kedro)

    for completion in $response
        set -l metadata (string split "," $completion)

        if test $metadata[1] = dir
            __fish_complete_directories $metadata[2]
        else if test $metadata[1] = file
            __fish_complete_path $metadata[2]
        else if test $metadata[1] = plain
            echo $metadata[2]
        end
    end
end

complete --no-files --command kedro --arguments "(_kedro_completion)"
