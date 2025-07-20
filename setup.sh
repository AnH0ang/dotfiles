#! /bin/sh

###############################################################################
# General                                                                     #
###############################################################################
# homebrew
# /opt/homebrew/bin/brew tap --force homebrew/cask
# /opt/homebrew/bin/brew tap --force homebrew/core
echo "Install homebrew packages..."
/opt/homebrew/bin/brew bundle install --file="${HOME}"/.config/homebrew/Brewfile

# Need to install custom version of libomp for lightgbm (See https://auto.gluon.ai/stable/install.html)
fix_libomp() {
    /opt/homebrew/bin/brew uninstall -f libomp
    /opt/homebrew/bin/wget https://raw.githubusercontent.com/Homebrew/homebrew-core/fb8323f2b170bd4ae97e1bac9bf3e2983af3fdb0/Formula/libomp.rb
    /opt/homebrew/bin/brew install libomp.rb
    rm libomp.rb
}
fix_libomp

# ssh
echo "Configure ssh..."
rm -rf "${HOME}"/.ssh
ln -fs "${HOME}"/.config/ssh "${HOME}"/.ssh

# vscode
echo "Configure vscode..."
mkdir -p "${HOME}"/Library/'Application Support'/Code/User
rm -f "${HOME}"/Library/'Application Support'/Code/User/settings.json
ln -sf "${HOME}"/.config/vscode/settings.jsonc "${HOME}"/Library/'Application Support'/Code/User/settings.json
rm -f "${HOME}"/Library/'Application Support'/Code/User/keybindings.json
ln -sf "${HOME}"/.config/vscode/keybindings.jsonc "${HOME}"/Library/'Application Support'/Code/User/keybindings.json
rm -f "${HOME}"/Library/'Application Support'/Code/User/mcp.json
ln -sf "${HOME}"/.config/vscode/mcp.jsonc "${HOME}"/Library/'Application Support'/Code/User/mcp.json

# zsh
echo "Configure zsh..."
ln -sf "${HOME}"/.config/shell/profile "${HOME}"/.zprofile
touch "${HOME}"/.hushlogin

# sh
echo "Configure shell..."
ln -sf "${HOME}"/.config/shell/profile "${HOME}"/.profile

# logseq
echo "Configure logseq..."
mkdir -p "${HOME}"/.logseq/config
ln -sf "${HOME}"/.config/logseq/config.edn "${HOME}"/.logseq/config/config.edn

# hidutil (key remaps)
echo "Configure hidutil..."
mkdir -p "$HOME"/Library/LaunchAgents
ln -sf "$HOME"/.config/hidutil/com.local.KeyRemapping.plist "$HOME"/Library/LaunchAgents/com.local.KeyRemapping.plist

# mise
echo "Install mise packages..."
/opt/homebrew/bin/mise install

# fish
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells >/dev/null
chsh -s /opt/homebrew/bin/fish

# use touch id for sudo
# If you fuck up read: https://medium.com/@zmre/quick-tip-fixing-the-sudo-file-on-macos-cf3c2a2584d4
use_touch_id_for_sudo() {
    # NOTE: In this future only this line will be needed
    # sudo sed -i '' -e 's/^#auth/auth/' /etc/pam.d/sudo_local.template
    line="auth       sufficient     pam_tid.so"
    file="/etc/pam.d/sudo_test"
    sudo grep -Fxq "$line" "$file" || sudo sed -i '' "2i\\
$line
" "$file"
}
use_touch_id_for_sudo

# uv tool (pipx)
uv tool install ruff
uv tool install sqlfluff
uv tool install nbconvert
uv tool install pex
uv tool install pydoclint

###############################################################################
# MacOS Setting                                                               #
###############################################################################
# ------------------------ UI & UX ------------------------
echo "Configure UI & UX..."

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "en" "de"
defaults write NSGlobalDomain AppleLocale -string "de_DE@currency=EUR"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set the timezone (see `sudo systemsetup -listtimezones` for other values)
# sudo systemsetup -settimezone "Europe/Berlin" >/dev/null

# Menu bar: show battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# ------------------------ Keyboard & Input ------------------------
echo "Configure Keyboard..."

# Make f keys behave as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Disable smart quotes and dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Enable Press and Hold for vscode (You need to log out for this to take effect)
# See: https://stackoverflow.com/questions/39972335/how-do-i-press-and-hold-a-key-and-have-it-repeat-in-vscode
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false          # VS Code
defaults write com.todesktop.230313mzl4w4u92 ApplePressAndHoldEnabled -bool false # Cursor
defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false     # VS Codium
defaults write com.jetbrains.pycharm ApplePressAndHoldEnabled -bool falsde        # PyCharm
defaults write com.jetbrains.pycharm.ce ApplePressAndHoldEnabled -bool falsde     # PyCharm Custom Edition
defaults write com.jetbrains.intellij ApplePressAndHoldEnabled -bool false        # IntelliJ Ultimate
defaults write com.jetbrains.intellij.ce ApplePressAndHoldEnabled -bool false     # IntelliJ Community Edition
defaults write md.obsidian ApplePressAndHoldEnabled -bool false                   # Obsidian
defaults delete -g ApplePressAndHoldEnabled                                       # If necessary, reset global default

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Disable automatic period substitution
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false

# ------------------------ Screen ------------------------
echo "Configure Screen..."

# Save screenshots to the desktop
mkdir -p "${HOME}/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# disable autosort of desktops
defaults write com.apple.dock mru-spaces -bool FALSE

# switch screen when activated
defaults write -g AppleSpacesSwitchOnActivate -bool true

# ------------------------ Safari ------------------------
echo "Configure Safari..."

# Disable Password AutoFill
defaults write -g AutoFillPasswords -int 0

# Enable Extensions
defaults write -g ExtensionsEnabled -int 1

# Restore last open windows and tabs at launch
defaults write -g AlwaysRestoreSessionAtLaunch -int 1

# Disable Password Protection of Private Browsing
defaults write -g PrivateBrowsingRequiresAuthentication -int 0

# ------------------------ iTerm2 ------------------------
echo "Configure iTerm2..."
# write preferences folder
# shellcheck disable=SC2088
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "~/.config/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -int 1

# ------------------------ Mail ------------------------
echo "Configure Mail..."

# Always include the whole message in the reply
defaults write com.apple.finder AlwaysIncludeOriginalMessage -int 1

# Mark the whole converteration as read
defaults write com.apple.finder ConversationViewMarkAllAsRead -int 1

# Have the newest message at the top
defaults write com.apple.finder ConversationViewSortDescending -int 1

# Show 3 lines of the message in the snippet
defaults write com.apple.finder NumberOfSnippetLines -int 3

# ------------------------ Spotlight ------------------------
echo "Configure Spotlight..."

defaults write com.apple.Spotlight "NSStatusItem Visible Item-0" -bool false
defaults write com.apple.Spotlight MenuItemHidden -bool true

# ------------------------ Finder ------------------------
echo "Configure Finder..."

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Synchronize Desktop & Documents folder with iCloud
defaults write com.apple.finder FXICloudDriveEnabled -bool true
defaults write com.apple.finder FXICloudDriveDesktop -bool true
defaults write com.apple.finder FXICloudDriveDocuments -bool true
defaults write com.apple.finder SidebarShowingiCloudDesktop -bool true

# Disable create .DS_Store files
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Set default view style to column
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"

# Don't allow quitting via ⌘Q
defaults write com.apple.finder QuitMenuItem -bool false

# ------------------------ Dock ------------------------
echo "Configure Dock..."

# Clear the Dock persistent-apps list (remove all apps)
defaults write com.apple.dock persistent-apps -array

# size
defaults write com.apple.dock tilesize -int 48

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Disable hot corners
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-br-corner -int 0

# Don't show recently used applications in the Dock
defaults write com.Apple.Dock show-recents -bool false

# Restart
killall Dock

# ------------------------ Rectangle ------------------------
echo "Configure Rectangle..."

defaults write com.knollsoft.Rectangle SUEnableAutomaticChecks -int 0
defaults write com.knollsoft.Rectangle SUHasLaunchedBefore -int 1
defaults write com.knollsoft.Rectangle allowAnyShortcut -int 1
defaults write com.knollsoft.Rectangle almostMaximize -dict keyCode -int 3 modifierFlags -int 524288
defaults write com.knollsoft.Rectangle alternateDefaultShortcuts -int 1
defaults write com.knollsoft.Rectangle bottomHalf -dict
defaults write com.knollsoft.Rectangle bottomLeft -dict
defaults write com.knollsoft.Rectangle bottomRight -dict
defaults write com.knollsoft.Rectangle center -dict keyCode -int 8 modifierFlags -int 524288
defaults write com.knollsoft.Rectangle gapSize -int 25
defaults write com.knollsoft.Rectangle hideMenubarIcon -int 1
defaults write com.knollsoft.Rectangle larger -dict
defaults write com.knollsoft.Rectangle lastVersion -int 82
defaults write com.knollsoft.Rectangle launchOnLogin -int 1
defaults write com.knollsoft.Rectangle leftHalf -dict keyCode -int 4 modifierFlags -int 524288
defaults write com.knollsoft.Rectangle maximize -dict keyCode -int 3 modifierFlags -int 655360
defaults write com.knollsoft.Rectangle maximizeHeight -dict
defaults write com.knollsoft.Rectangle nextDisplay -dict
defaults write com.knollsoft.Rectangle previousDisplay -dict
defaults write com.knollsoft.Rectangle reflowTodo -dict keyCode -int 45 modifierFlags -int 786432
defaults write com.knollsoft.Rectangle restore -dict keyCode -int 51 modifierFlags -int 524288
defaults write com.knollsoft.Rectangle rightHalf -dict keyCode -int 37 modifierFlags -int 524288
defaults write com.knollsoft.Rectangle smaller -dict
defaults write com.knollsoft.Rectangle subsequentExecutionMode -int 1
defaults write com.knollsoft.Rectangle toggleTodo -dict keyCode -int 11 modifierFlags -int 786432
defaults write com.knollsoft.Rectangle topHalf -dict
defaults write com.knollsoft.Rectangle topLeft -dict
defaults write com.knollsoft.Rectangle topRight -dict
defaults write com.knollsoft.Rectangle unsnapRestore -int 2
defaults write com.knollsoft.Rectangle windowSnapping -int 2

# ------------------------ Hotkeys ------------------------
echo "Configure Symbolic Hotkey..."

# Switch Desktops
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 118 "<dict> <key>enabled</key> <true/> <key>value</key> <dict> <key>parameters</key> <array> <integer>65535</integer> <integer>10</integer> <integer>524288</integer> </array> <key>type</key> <string>standard</string> </dict> </dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 119 "<dict> <key>enabled</key> <true/> <key>value</key> <dict> <key>parameters</key> <array> <integer>49</integer> <integer>18</integer> <integer>524288</integer> </array> <key>type</key> <string>standard</string> </dict> </dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 120 "<dict> <key>enabled</key> <true/> <key>value</key> <dict> <key>parameters</key> <array> <integer>50</integer> <integer>19</integer> <integer>524288</integer> </array> <key>type</key> <string>standard</string> </dict> </dict>"

defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 122 "<dict> <key>enabled</key> <true/> <key>value</key> <dict> <key>parameters</key> <array> <integer>52</integer> <integer>21</integer> <integer>524288</integer> </array> <key>type</key> <string>standard</string> </dict> </dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 123 "<dict> <key>enabled</key> <true/> <key>value</key> <dict> <key>parameters</key> <array> <integer>53</integer> <integer>23</integer> <integer>524288</integer> </array> <key>type</key> <string>standard</string> </dict> </dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 124 "<dict> <key>enabled</key> <true/> <key>value</key> <dict> <key>parameters</key> <array> <integer>54</integer> <integer>22</integer> <integer>524288</integer> </array> <key>type</key> <string>standard</string> </dict> </dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 125 "<dict> <key>enabled</key> <true/> <key>value</key> <dict> <key>parameters</key> <array> <integer>55</integer> <integer>26</integer> <integer>524288</integer> </array> <key>type</key> <string>standard</string> </dict> </dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 126 "<dict> <key>enabled</key> <true/> <key>value</key> <dict> <key>parameters</key> <array> <integer>56</integer> <integer>28</integer> <integer>524288</integer> </array> <key>type</key> <string>standard</string> </dict> </dict>"

# Disable Spotlight
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 "<dict><key>enabled</key><false/></dict>"

# Disable Prev/Next Input
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/></dict>"
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 "<dict><key>enabled</key><false/></dict>"

# ------------------------ Calendar ------------------------
echo "Configure Calendar..."

# Week starts on monday
defaults write com.apple.iCal "first day of week" -int 2

# Show 16 hours in day view
defaults write com.apple.iCal "number of hours displayed" -int 16

# ------------------------ Software Updates ------------------------
echo "Configure Software Updates ..."

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -bool true

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -bool true

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -bool true

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# Allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true
