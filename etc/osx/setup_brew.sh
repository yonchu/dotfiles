#!/bin/bash
#
# Homebrew
#
set -u

ROOT_DIR="$HOME/dotfiles/etc/osx"

BREW_LIST="$ROOT_DIR/brew_list.txt"
TAP_LIST="$ROOT_DIR/brew_tap.txt"

EXCLUSION_LIST=(git python)

# Check for Homebrew
echo 'Check for Homebrew'
if ! type brew > /dev/null 2>&1; then
  echo '  x You should probably install Homebrew first:'
  echo '    https://github.com/mxcl/homebrew/wiki/installation'
  exit 1
else
  echo '  + Homebrew found.'
fi

echo 'Check install list'
if ! [ -f "$BREW_LIST" ]; then
    echo "  x $BREW_LIST not found." 1>&2
    exit 1
else
    echo "  + Package list : $BREW_LIST"
fi

if ! [ -f "$TAP_LIST" ]; then
    echo "  x $TAP_LIST not found." 1>&2
    exit 1
else
    echo "  + Tap list : $BREW_LIST"
fi

echo 'Setup Homebrew starts!!'

# Install git
echo 'Install git...'
brew install git

# Make sure we’re using the latest Homebrew
echo 'Update...'
brew update

# tap
echo 'Set tap!!'
for tap in $(cat "$TAP_LIST"); do
    echo "  + Add $tap"
    brew tap "$tap"
done

# Install packages
echo "Install packages!!"
for pkg in $(cat "$BREW_LIST"); do
    echo -n "Install ${pkg}"
    for ex in "${EXCLUSION_LIST[@]}"; do
        if [ "$pkg" = "$ex" ]; then
            echo -n '...skip'
            break
        fi
    done
    echo
    brew install "$pkg"
done

# Install packages
echo "Install packages individually!!"
echo 'Install python'
brew install python

echo 'Check brew doctor!!'
brew doctor

echo 'Setup brew completion!!'
ln -s /usr/local/Library/Contributions/brew_zsh_completion.zsh /usr/local/share/zsh/functions/_brew

echo 'Setup Homebrew completed!!'

