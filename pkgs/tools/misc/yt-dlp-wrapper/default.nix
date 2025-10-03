{ yt-dlp, writeShellScriptBin }:

writeShellScriptBin "yt-dlp-wrapper.sh"
''
#!/usr/bin/env bash

maxnum="99999999"
nothumbs=0
vidres="1080"

while getopts ":c:d:a:n:r:" opt; do
    case "$opt" in
        c) content=$OPTARG ;;
        d) dest=$OPTARG ;;
        a) audio=$OPTARG ;;
        n) maxnum=$OPTARG ;;
        r) vidres=$OPTARG ;;
        --nothumbnails) nothumbs=1 ;;
    esac
done
shift $(( OPTIND - 1 ))

if [ -z "$content" ]; then 
    echo "No content (-c) specified, there is nothing to download.."
fi 

if [ -z "$dest" ]; then 
    echo "Destination (-d) not provided, setting to current directory."
    dest=$PWD
fi

if [[ ! -z "$content" && ! -z "$dest" ]]; then
    echo "Downloading $content to $dest..."
    mkdir -p $dest 

    if [ $audio ]; then
        ${yt-dlp}/bin/yt-dlp "$content" --output "$dest/%(title)s.%(ext)s" \
            -x \
            --restrict-filenames \
            --format "bestaudio[protocol^=m3u8]/bestaudio" \
            --audio-format mp3 \
            --audio-quality 0 \
            --max-downloads $maxnum \
            --no-mtime \
            --embed-thumbnail \
            --embed-metadata \
            --verbose
    else 
        ${yt-dlp}/bin/yt-dlp "$content" --output "$dest/%(title)s/%(title)s.%(ext)s" \
            `[[ nothumbs -le 0 ]] && echo "--output "thumbnail:$dest/%(title)s/thumbnails/"` \
            --format "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" \
            --format-sort res:$vidres,fps \
            --restrict-filenames \
            --merge-output-format mp4 \
            --write-info-json \
            --write-annotations \
            --write-description \
            --write-all-thumbnails \
            --embed-thumbnail \
            --embed-metadata \
            --embed-subs \
            --embed-chapters \
            --max-downloads $maxnum \
            --verbose
    fi
fi
''
