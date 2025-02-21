#!/usr/bin/env bash

# This file is part of The RetroPie Project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="cdogs-sdl-0.7.2"
rp_module_desc="C-Dogs SDL - Classic overhead run-and-gun game"
rp_module_licence="GPL2 https://raw.githubusercontent.com/cxong/cdogs-sdl/master/COPYING"
rp_module_repo="git https://github.com/cxong/cdogs-sdl.git 0.7.2"
rp_module_section="exp"
rp_module_flags="sdl1 !mali"

function depends_cdogs-sdl-0.7.2() {
    getDepends cmake libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev
}

function sources_cdogs-sdl-0.7.2() {
    gitPullOrClone
}

function build_cdogs-sdl-0.7.2() {
    cmake . -DCMAKE_INSTALL_PREFIX="$md_inst" -DCDOGS_DATA_DIR="$md_inst/"
    make
    md_ret_require="$md_build/src/cdogs-sdl"
}

function install_cdogs-sdl-0.7.2() {
    md_ret_files=(
        'data'
        'dogfights'
        'graphics'
        'missions'
        'music'
        'sounds'
        'COPYING'
        'src/cdogs-sdl'
        'src/cdogs-sdl-editor'
    )
}

function configure_cdogs-sdl-0.7.2() {
    addPort "$md_id" "cdogs-sdl" "C-Dogs SDL" "pushd $md_inst; $md_inst/cdogs-sdl; popd"

    [[ "$md_mode" == "remove" ]] && return

    isPlatform "dispmanx" && setBackend "$md_id" "dispmanx"

    moveConfigDir "$home/.config/cdogs-sdl" "$md_conf_root/cdogs-sdl"
}
