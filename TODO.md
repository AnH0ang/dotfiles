# TODO

1.  Configure Raycast
2.  Give iTerm2 and VSCode full disk access
3.  Configure Rectangle
4.  Create desktops and assign apps to them
5.  Add small spacers to dock
    ```sh
    defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'
    killall Dock
    ```