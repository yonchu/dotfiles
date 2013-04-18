#!/bin/sh

./backup_brew.sh

pip freeze > pip.txt
npm -g list > npm.txt
gem list > gem.txt
