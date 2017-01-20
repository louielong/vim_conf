#! /bin/bash

#---------------------------------------------------------------
# SV view
#---------------------------------------------------------------
function go_sv()
{
    case "$cmd2" in
        #"ctl" )
        #    export WS_=$(WORKSPACE)/pica/ovs
        #    export WS_TAG_=ctrlr
        #    export WS_DESC_=" controler "
        #    export WS_BASE_=$WS_/$WS_TAG_
        #;;
        "pica")
            export WS_=$(ROOT_PATH)
            export WS_TAG_=pica
            export WS_DESC_=" PicaOS"
            export WS_BASE_=$WS_/$WS_TAG_
        ;;
        "sw" )
            export WS_=$(ROOT_PATH)/ovs
            export WS_TAG_=openvswitch-2.3.0
            export WS_DESC_=" Switch Code "
            export WS_BASE_=$WS_/$WS_TAG_
        ;;
        #"yoc" )
        #    export WS_=$(WORKSPACE)
        #    export WS_TAG_=poky
        #    export WS_DESC_="YACTO build environment"
        #    export WS_BASE_=$WS_/$WS_TAG_
        #;;
        "dr" )
            echo $(ROOT_PATH)
            export WS_=$(ROOT_PATH)/$(LINUX_KERNEL_PATH)
            export WS_TAG_=driver
            export WS_DESC_="Driver Code "
            export WS_BASE_=$WS_/$WS_TAG_
        ;;
        "kr" )
            export WS_=$(ROOT_PATH)/$(LINUX_KERNEL_PATH)
            export WS_TAG_=linux_kernel
            export WS_DESC_="Kernel Code "
            #export WS_BASE_=$WS_/$WS_TAG_
            export WS_BASE_=`pwd`
        ;;
        "." )
            export WS_DESC_="Kernel Code "
            export WS_BASE_=`pwd`
        ;;
        "c" | "clear")
            export WS_TAG_=""
            export WS_DESC_=""
            export WS_BASE_=""
            return
        ;;
        "-i" )
            cat $WS_BASE_/$COMMON_INFO_DIR/sv_log
            return
        ;;
        * )
            echo "UNKNOWN VIEW [$cmd2] NOT PRESENT @ [`uname -n`]"
            export WS_TAG_=""
            export WS_DESC_=""
            export WS_BASE_=""
            return
        ;;
    esac

    if [ "$cmd2" != "" ]
    then

        if [ ! -d $WS_BASE_ ]
        then
            echo $WS_BASE_
            echo "View [$WS_TAG_: $WS_DESC_] NOT PRESENT @ [`uname -n`]"
            export WS_TAG_=""
            export WS_DESC_=""
            export WS_BASE_=""
            cd
            return
        fi

        #cd $WS_BASE_
        if [ ! -d $COMMON_INFO_DIR ]
        then
            mkdir $COMMON_INFO_DIR
        fi

        echo "View Set @ $WS_TAG_ [$WS_DESC_] [`pwd`]"
    fi
}

#---------------------------------------------------------------
# go_upt()
#
# TODO
#  -> Create a fresh branch and build
#  -> update the exsisting branch and build
#---------------------------------------------------------------
function go_upt()
{
    case "$cmd2" in
        "ct" | "cs" | "tool" )
            if [ "$cmd3" = "." ]
            then
                dir_=`pwd`
            else
                dir_=$WS_BASE_
            fi

            cd $dir_
            code_br_upt
        ;;
        * )
            echo "Unknown update request"
        ;;
    esac
}

#---------------------------------------------------------------
# code_br_upt()
#---------------------------------------------------------------
function code_br_upt()
{
    if [ ! -d $BR_INFO_DIR ]; then
        mkdir $BR_INFO_DIR
    fi
    echo "build cscope here $dir_/$BR_INFO_DIR"
    cscope_upt
    ctag_upt
}

#---------------------------------------------------------------
# cscope_upt()
#---------------------------------------------------------------
function cscope_upt()
{
    echo "Cleanning up the OLD cscope..."
    rm -f $BR_INFO_DIR/cscope.*

    echo "MAKING the cscope.file..."
    list_file
    echo "done with MAKING the cscope.file..."

    echo "cscope -bqv -i ./cscope.files..."
    cd $BR_INFO_DIR; cscope -bqv -i cscope.files; cd -;
    echo "DONE ... "
    echo "-> Cscope updated on [`date`]@[`uname -n`]" >> $WS_BASE_/$COMMON_INFO_DIR/sv_log

}

function list_file()
{
    find `pwd` -type f -name "*.[cChH]" >> $BR_INFO_DIR/cscope.files;
    find `pwd` -type f -name '*.cc' >> $BR_INFO_DIR/cscope.files;
    find `pwd` -type f -name '*.hh' >> $BR_INFO_DIR/cscope.files;
    find `pwd` -type f -name Makefile  >> $BR_INFO_DIR/cscope.files;
    find `pwd` -type f -name README  >> $BR_INFO_DIR/cscope.files;
    find `pwd` -type f -name '*.asm'  >> $BR_INFO_DIR/cscope.files;
}

#---------------------------------------------------------------
# ctag_upt()
#---------------------------------------------------------------
function ctag_upt()
{
    echo "Start to build ctags"
    rm -f $BR_INFO_DIR/tags
    cd $BR_INFO_DIR; ctags -L cscope.files; cd - ;
    echo "Done"
    echo "-> Cscope updated on [`date`]@[`uname -n`]" >> $WS_BASE_/$COMMON_INFO_DIR/sv_log
}

#---------------------------------------------------------------
# go_misc
#   @ For now this function just sets the dir.
#---------------------------------------------------------------
function go_misc()
{
    local err_flg=0
    dir_="";

    # View specific dirs
    case "$WS_TAG_" in
        "pica" )
            case "$marg" in
                "ctl" | "c" )
                    dir_="$WS_BASE_/../ovs/ctrlr"
                ;;
                "sw" )
                    dir_="$WS_BASE_/../ovs/openvswitch-2.3.0"
                ;;
                "rtm" )
                    dir_="$WS_BASE_/../ovs/ctrlr/routemgr"
                ;;
                "sdk" )
                    dir_="$WS_BASE_/../sdk"
                ;;
            esac
        ;;
        "ctrlr" )
            case "$marg" in
                "rtm" )
                    dir_="$WS_BASE_/routemgr"
                ;;
                "ctl" )
                    dir_="$WS_BASE_"
                ;;
            esac
        ;;
    esac

    if [  -z $dir_ ]
    then
        case "$marg" in
            "b" | "base" )
                if [ -z $WS_BASE_ ]
                then
                    dir_=~/workspace
                else
                    dir_=$WS_BASE_
                fi
            ;;
            "." | "dot" )
                dir_=~/.vim
            ;;
            "exp" )
                dir_=~/workspace/scratch/experiment
            ;;
            "w" )
                if [[ "$__PLATFORM__" == 'Darwin' ]]; then
                    dir_=~/Documents/Work
                elif [[ "$__PLATFORM__" == 'Linux' ]]; then
                    err_flg=1
                fi
            ;;
            * )
                err_flg=1
            ;;
        esac
    fi

    if (( err_flg == 1 ))
    then
        echo "Unknown module $marg"
    else
        if [ -e $dir_ ]
        then
            cd $dir_; echo `pwd`
        else
            echo "Set the view: location [ $dir_ ] not found"
        fi
    fi
}

#---------------------------------------------------------------
# Variable init
#---------------------------------------------------------------
function var_init ()
{
    cmd1=""
    cmd2=""
    cmd3=""
    cmd4=""
    cmd5=""
    marg=""
    cmd_v=""
    dir_=""
    export BR_INFO_DIR=.__branch_info_$(uname)_
    export COMMON_INFO_DIR=.__common_info_
}

# Working Copy Root Path for pica & ovs
function ROOT_PATH {

SVN_VR=`svn --version | grep svn, | awk '{print $3}'`
if [ $SVN_VR \< 1.7 ]; then
        os_pica=$(svn info 2>/dev/null | sed -ne 's#^URL: ##p')
        os_pica=`echo ${os_pica#*://*/*/}`
	#Root Path
	line=$(svn info 2>/dev/null | sed -ne 's#^URL: ##p')
	line=`echo ${line#*://*/*/}`
	PWD_TMP=`echo ${line#*/*/}`
	line=$(echo ${PWD%/$PWD_TMP})
else
	os_pica=$(svn info 2>/dev/null | sed -ne 's#^Relative URL: ##p')
	#Root Path
	line=$(svn info 2>/dev/null | sed -ne 's#^Working Copy Root Path: ##p')
fi

case "$os_pica" in
    *"pica"* )
        PWD_TMP=`echo $line`
        echo $PWD_TMP
        ;;
    *"ovs"* )
        PWD_TMP=`echo $line`
        echo $PWD_TMP
        ;;
    *"driver"* )
        PWD_TMP=`echo $line`
        echo $PWD_TMP
        ;;
    *"linux-kernel"* )
        PWD_TMP=`echo $line`
        echo $PWD_TMP
        ;;
    * )
        PWD_TMP=
        echo $PWD_TMP
        ;;
esac
}

# Os-dev for linux kernel & driver
function LINUX_KERNEL_PATH {
SVN_VR=`svn --version | grep svn, | awk '{print $3}'`
if [ $SVN_VR \< 1.7 ]; then
        line=$(svn info 2>/dev/null | sed -ne 's#^URL: ##p')
        line=`echo ${line#*://*/*/}`
	PWD_TMP=`echo ${line#*/*/}`
else
        line=$(svn info 2>/dev/null | sed -ne 's#^Relative URL: ##p')
	PWD_TMP=`echo ${line#*/*/*/}`
fi

#line=$(svn info 2>/dev/null | sed -ne 's#^Relative URL: ##p')
#PWD_TMP=`echo ${line#*/*/*/}`
case "$line" in
    *"driver"* )
        WORKSPACE=`echo ${PWD_TMP%%/driver*}`
        echo "$WORKSPACE"
        ;;
    *"linux-kernel"* )
        WORKSPACE=`echo ${PWD_TMP%%/linux-kernel*}`
        echo "$WORKSPACE"
        ;;
    * )
        WORKSPACE=
        echo "$WORKSPACE"
        ;;
esac
}
#---------------------------------------------------------------
# The Script Starts here
#---------------------------------------------------------------
var_init
if (( $# == 1 ))
then
    #cmd1="misc"
    cmd1="sv"
    marg=$1

    case "$marg" in
        "-h" | "--h" | "help" | "h" | "-help" )
            cmd1="help"
        ;;
        "setup" )
            cmd1="setup"
        ;;
   esac
else
    cmd1=$1
    cmd2=$2
    cmd3=$3
    cmd4=$4
    cmd5=$5
    cmd6=$6
    cmd7=$7
    cmd8=$8
    cmd_v=$#
fi

#echo " (arg1) : $1 (arg2) : $2 (number of arg) : $# "
#echo " (cmd1) : $cmd1 (cmd2) : $cmd2 (cmd3) : $cmd3
#       (cmd4) : $cmd4 (cmd5) : $cmd5  marg $marg "

case "$cmd1" in
    "sv" )
        go_sv
    ;;
#    "setup" )
#        echo "setting up .."
#        sudo source ~/.vim/scripts/setp.sh
#    ;;
    "upt" | "u" | "up" )
        go_upt
    ;;
#    "node" | "load" )
#        go_node
#    ;;
#    "misc" )
#        go_misc
#    ;;
#    "help" )
#        go_help
#    ;;
esac

#---------------------------------------------------------------
# TODO
#---------------------------------------------------------------

    # go_help()
    # go_node()
    # go_bu()

#---------------------------------------------------------------
