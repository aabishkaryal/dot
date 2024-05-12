#!/bin/zsh

function svg_to_icns(){
    local RESOLUTIONS=(
        16,16x16
        32,16x16@2x
        32,32x32
				30,30x30
				44,44x44
				50,50x50
        64,32x32@2x
        71,71x71
        89,89x89
				107,107x107
        128,128x128
				142,142x142
				150,150x150
        256,128x128@2x
        256,256x256
				284,284x284
				310,310x310
        512,256x256@2x
        512,512x512
        1024,512x512@2x
    )

    for SVG in $@; do
      BASE=$(basename "$SVG" | sed 's/\.[^\.]*$//')
        ICONSET="$BASE.iconset"
        ICONSET_DIR="./icons/$ICONSET"
        mkdir -p "$ICONSET_DIR"
        for RES in ${RESOLUTIONS[@]}; do
            SIZE=$(echo $RES | cut -d, -f1)
            LABEL=$(echo $RES | cut -d, -f2)
            svg2png -w $SIZE -h $SIZE "$SVG" "$ICONSET_DIR"/icon_$LABEL.png
        done

        iconutil -c icns "$ICONSET_DIR"
    done
}

svg_to_icns "$@"
