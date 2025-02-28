#!/bin/bash
#set +x 

faStabilo='\033[7m'
fcRouge='\033[31m'
fcJaune='\033[33;1m'
fcCyan='\033[36m'
fcGreen='\033[32m'
fcBleu='\033[34m'
fcNoir='\033[0;0m'

faGras='\033[1m'

printf '\e[8;'24';'120't'

f_cls() {

reset > /dev/null
    echo -en '\033[1;1H'
    echo -en '\033]11;#000000\007'
    echo -en '\033]10;#FFFFFF\007'     
}

f_pause(){
    echo -en '\033[0;0m'
     echo -en $faStabilo$fcRouge'Press[Enter] key to continue'
    tput civis     # curseur invisible
    read -s -n 1
    echo -en '\033[0;0m'
}


projet_lib=$HOME"/Zdate/create_timezones/"
name_src="create_timezones.zig"

folder_cache_zig=$HOME"/.cache/zig"
folder_cache_zls=$HOME"/.cache/zls"
folder_bin="./zig-out/bin/"${name_src%.*}

#type Compile


f_clear_Cache() {

if test -d "$projet_lib" ; then
        find $projet_lib -type d -name .zig-cache | while read line; do
        rm -r "$line"
    done
fi

if test -d "$folder_src" ; then
        find $folder_src -type d -name  zig-out | while read line; do
        rm -r "$line"
    done
fi
} 
#=========================
# Func ok Compile 
#=========================
f_read_RESUTAT() {    #RESULTAT

    echo -en $faStabilo$fcCyan"BUILD "$mode $fcNoir "  " $fcJaune$name_src $fcNoir "->" $fcCyan $projet_bin $fcNoir
    echo -en "  size : "
    ls -lrtsh $folder_bin | cut -d " " -f6


    if test -d "zig-out" ; then
        find "zig-out" -type d -name  zig-out | while read line; do
        rm -r "$line"
        done
    fi

    f_clear_Cache
    
    echo -en '\033[0;0m';
}

# DEBUG
# resize 
    f_cls
    echo -e $faStabilo$fcGreen"Compile"$fcNoir

    ( set -x ; \
        ~/.zig/zig build run -Doptimize=Debug --build-file $projet_lib"build"$name_src ;\
    )

    if test -f "$folder_bin" ; then
            f_read_RESUTAT
        else
            f_clear_Cache
        fi

        f_pause
tput cnorm
exit 0
