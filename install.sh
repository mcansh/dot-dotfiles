#!/usr/bin/env bash

# Set HostName/ComputerName/LocalHostName
sudo -u $USER scutil --set ComputerName "🚀😺"
sudo -u $USER scutil --set LocalHostName "mcansh"
sudo -u $USER scutil --set HostName "mcansh"
echo "> 1/4 Host name is set to $(hostname)"

# Mac configuration
echo "> 2/4 Setting up computer configuration"
sudo -u $USER systemsetup -setcomputersleep 2 # Computer sleeps after 2 minutes
defaults write com.apple.screensaver askForPassword 1 # Force password entry after sleep
defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "This computer belongs to Logan McAnsh" # add a message to the login screen
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false # stop safari from opening downloaded files automatically
defaults write com.apple.dock autohide -bool true && defaults write com.apple.dock autohide-delay -float 0 && defaults write com.apple.dock autohide-time-modifier -float 0 && killall Dock # autohide dock and remove delay
defaults write com.apple.Dock orientation -string left # position the dock on the left side
defaults write com.apple.PowerChime ChimeOnAllHardware -bool true; open /System/Library/CoreServices/PowerChime.app & # enable the PowerChime
defaults write NSGlobalDomain _HIHideMenuBar -bool true # autohide the menubar
defaults write NSGlobalDomain AppleInterfaceStyle Dark # dark dock/menubar
killall Dock # restart dock
killall -KILL SystemUIServer # restart menubar


# Check if FileValut is on
if [ "$(fdesetup status)" == "FileVault is On." ]; then
  echo "> 3/4 Disk encryption is already enabled. 🔥"
fi

if [ "$(fdesetup status)" == "FileVault is Off." ]; then
  echo "Disk encryption not enabled. Enabling now..."
  fdesetup enable
  echo "> 3/4 Disk encryption is now enabled. 💯🔥"
fi

# Install Brew
sudo -u $USER /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install ZSH
sudo -u $USER brew install zsh zsh-completions

# Install oh my ZSH
sudo -u $USER /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install Zeit's theme (usage is in .zshrc)
sudo -u $USER curl https://raw.githubusercontent.com/zeit/zeit.zsh-theme/master/zeit.zsh-theme -Lo ~/.oh-my-zsh/themes/zeit.zsh-theme

# Setup Software
sudo -u $USER brew install mas # We will need this in a bit for installing MAS
sudo -u $USER brew install gnupg21 android-platform-tools gifify hub pinentry-mac thefuck
sudo -u $USER brew tap caskroom/cask
sudo -u $USER brew tap caskroom/versions
sudo -u $USER brew tap homebrew/bundle
sudo -u $USER brew tap homebrew/core
sudo -u $USER brew tap homebrew/dupes
sudo -u $USER brew cask install Caskroom/cask/$cask_apps
sudo -u $USER brew bundle

echo "> 4/4 Installing software from cask... (may take a bit if your internet is shit)"
cask_apps=('1password' 'handbrake' 'codekit' 'hyper' 'dropbox' 'slack-beta' 'firefoxnightly' 'visual-studio-code-insiders' 'google-chrome-canary' 'whiskey' 'google-chrome-dev' 'zoomus')
brew cask install $cask_apps

# Mac Software Update Check and install updates
softwareupdate -ia --verbose

# WE OUT
echo "> Welcome to your newly configured MacBook"
