#!/bin/bash -u

ARCHIVE_URLS=(
https://github.com/downloads/BrianGilbert/QLColorCode-extra/QLColorCode-extra.zip
http://www.sagtau.com/media/QuickLookJSON.qlgenerator.zip
http://kainjow.com/downloads/ScriptQL_qlgenerator.zip
https://github.com/downloads/whomwah/qlstephen/QLStephen.qlgenerator.zip
https://github.com/downloads/toland/qlmarkdown/QLMarkdown-1.3.zip
http://quicklook-csv.googlecode.com/files/QuickLookCSV.dmg
http://macitbetter.com/BetterZipQL.zip
http://www.mothersruin.com/software/downloads/SuspiciousPackage.dmg
https://github.com/downloads/Nyx0uf/qlImageSize/qlImageSize.qlgenerator.zip
https://github.com/downloads/mootoh/DayOneQuickLookPlugin/DayOneQuickLookPlugin.qlgenerator.zip
https://github.com/downloads/planbnet/QuickNFO/QuickNFO.qlgenerator.zip
)

GIT_URLS=(
https://github.com/macieks72/QLSqlite3.git
https://github.com/kikaigyo/QLHTML.git
)

BUILD_DIRS=(
QLSqlite3
)

#http://brushviewer.sourceforge.net/brushviewql.zip
#http://sourceforge.net/projects/animgifqlgen/


### main
TEMP_DIR=$(mktemp -d tmp.XXXXXXXX)
cd "$TEMP_DIR"

SRC_DIR='src'
mkdir "$SRC_DIR"

download() {
    local url
    for url in "${ARCHIVE_URLS[@]}"; do
        echo "Downloading ${url}..."
        curl -OLkf --progress-bar "$url"
    done

    for url in "${GIT_URLS[@]}"; do
        echo "git clone ${url}..."
        git clone "$url"
    done
}

extract() {
    local archive
    local file
    local mount_point
    for archive in *; do
        if [ ! -f "$archive" ] ; then
            continue
        fi

        case "$archive" in
            *.tgz)
                echo "Extracting ${archive}..."
                tar xzf "$archive"
                mv "$archive" "$SRC_DIR"
                ;;
            *.zip)
                echo "Extracting ${archive}..."
                unzip "$archive" > /dev/null
                mv "$archive" "$SRC_DIR"
                ;;
            *.dmg)
                echo "Mount ${archive}..."
                mount_point='dmg_mp'
                hdiutil attach -nobrowse -mountpoint "$mount_point" "$archive" > /dev/null
                sleep 1
                file=$(ls -1 "$mount_point" | grep '\.qlgenerator')
                cp -r "$mount_point/$file" .
                hdiutil unmount "$mount_point" > /dev/null
                mv "$archive" "$SRC_DIR"
                ;;
            *)
                echo "Skip: $archive" 1>&2
                ;;
        esac
    done
}

build() {
    local dir
    for dir in "${BUILD_DIRS[@]}"; do
        ( cd "$dir" && xcodebuild ) && mv "$dir"/build/Release/*.qlgenerator .
    done
}

download
extract
build

cd ..
PLUGINS_DIR="qlplugins"
mkdir "$PLUGINS_DIR"
find "$TEMP_DIR" -name '*.qlgenerator' -print0 | xargs -0 -J % cp -r % "$PLUGINS_DIR"
rm -rf "$TEMP_DIR"
sudo chown -R root:wheel "$PLUGINS_DIR"
sudo find "$PLUGINS_DIR" -depth 1 -name '*.qlgenerator' -print0 | xargs -0 -J % sudo cp -pr % /Library/QuickLook
sudo patch -p0 < QLColorCode.patch
sudo qlmanage -r

