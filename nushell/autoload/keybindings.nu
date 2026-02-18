$env.config.keybindings ++= [
    {
        modifier: control
        keycode: char_f
        mode: vi_insert
        event: {
            until: [
            { send: MenuRight }
            { send: HistoryHintComplete }
            ]
        }
    }
    {
        modifier: control
        keycode: char_b
        mode: vi_insert
        event: { send: MenuLeft }
    }
    {
        modifier: control
        keycode: char_o
        mode: vi_insert
        event: { send: executehostcommand cmd: "z-cd" }
    }
    {
        modifier: control
        keycode: char_l
        mode: vi_insert
        event: { send: executehostcommand cmd: "yazi-cd" }
    }
    {
        modifier: control
        keycode: char_e
        mode: vi_insert
        event: { send: openeditor }
    }
]
