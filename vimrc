"==============================================================================
"Pathogen
"==============================================================================
execute pathogen#infect()
syntax on
filetype plugin indent on

"==============================================================================
"coding standard guidelines.
"==============================================================================
set shiftwidth=4 tabstop=4
set softtabstop=4
set nosmarttab expandtab
"set textwidth=80                "line width
" 80 characters line
set colorcolumn=80
set term=screen-256color

"==============================================================================
"Vim settings
"==============================================================================
"set ruler                       "disply the row col number in the task bar
set ic                          "ignore case in search
set laststatus=2                "status bar on always
"set showtabline=2               "tab bar on alwasy
"set splitright                  "new window alwasys on right
set wildmenu                    "smart cmd completion option on status bar
set wildmode=full               "smart cmd completion option on status bar zsh
set autoindent                  "next line starts in the same point
set incsearch                   "highlights search patter while typing the pattern
set hlsearch                    "highlights all the search pattern
set tagstack                    "Control t and ] for tags.
"set guioptions-=T               "Disable the tools bar for gvim
set ch=2                        "set the command line high
set tabpagemax=10               "Set tab limits
set fillchars+=vert:\           "Set the vertical split without any char
set cursorline                  "higlight the cursor line
set number                      "Show line number
set history=200                 "set the history 200 command line
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set langmenu=zh_CN.UTF-8
set helplang=cn
set ff=unix
set nobackup                    "从不备份
set noeb                        "去掉输入错误的提示声音
set autowrite                   "自动保存
set clipboard+=unnamed          " 共享剪贴板

map <C-E> :%s/\s\+$//

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建 .py .c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
	"如果文件类型为.sh文件
	if &filetype == 'sh'
		call setline(1,"\#########################################################################")
		call append(line("."), "\# File Name: ".expand("%"))
		call append(line(".")+1, "\# Author: louie.long")
		call append(line(".")+2, "\# Mail: ylong@biigroup.cn")
		call append(line(".")+3, "\# Created Time: ".strftime("%c"))
		call append(line(".")+4, "\# Description:")
		call append(line(".")+5, "\#########################################################################")
		call append(line(".")+6, "\#!/bin/sh")
		call append(line(".")+7, "")
	else
		call setline(1, "/*************************************************************************")
		call append(line("."),   "\* > File Name: ".expand("%"))
		call append(line(".")+1, "\* > Author: louie.long")
		call append(line(".")+2, "\* > Mail: ylong@biigroup.cn")
		call append(line(".")+3, "\* > Created Time: ".strftime("%c"))
		call append(line(".")+4, "\* > Description:")
		call append(line(".")+5, "*************************************************************************")
		call append(line(".")+6, "\*/")
		call append(line(".")+7, "")
		call append(line(".")+8, "#include <stdio.h>")
		call append(line(".")+9, "#include <stdlib.h>")
		call append(line(".")+10, "#include <string.h>")
		call append(line(".")+11, "#include <errno.h>")
		call append(line(".")+12, "#include <unistd.h>")
	endif
	if &filetype == 'cpp'
		call append(line(".")+13, "#include <iostream>")
		call append(line(".")+14, "using namespace std;")
		call append(line(".")+15, "")
		call append(line(".")+16, "")
		call append(line(".")+17, "int main(int argc, char *argv[])")
		call append(line(".")+18, "{")
		call append(line(".")+19, "")
		call append(line(".")+20, "")
		call append(line(".")+21, "    return 0;")
		call append(line(".")+22, "}")
	endif
	if &filetype == 'c'
		call append(line(".")+12, "")
		call append(line(".")+14, "")
		call append(line(".")+15, "int main(int argc, char *argv[])")
		call append(line(".")+16, "{")
		call append(line(".")+17, "")
		call append(line(".")+18, "")
		call append(line(".")+19, "")
		call append(line(".")+20, "    return 0;")
		call append(line(".")+21, "}")
	endif
	"	if &filetype == 'java'
	"		call append(line(".")+6,"public class ".expand("%"))
	"		call append(line(".")+7,"")
	"	endif
	"新建文件后，自动定位到文件末尾
	autocmd BufNewFile * normal G
endfunc

autocmd BufNewFile *.py  exec ":call HeaderPython()"
function HeaderPython()
    call setline(1, "#!/usr/bin/env python")
	call append(line("."), "# -*- coding=utf-8 -*-")
	call append(line(".")+1, "")
    call append(line(".")+2, "# > File Name: ".expand("%"))
	call append(line(".")+3, "# > Author: louie.long")
	call append(line(".")+4, "# > Mail: ylong@biigroup.cn")
	call append(line(".")+5, "# > Created Time: ".strftime("%c"))
    normal G
    normal o
    normal o
endfunc

autocmd BufRead *.py nmap <F5> :w<CR>:!python %<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" C，C++ 按F5编译运行
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!gcc % -o %<"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!java %<"
	elseif &filetype == 'sh'
		:!./%
	elseif &filetype == 'py'
		exec "!python %"
		exec "!python %<"
	endif
endfunc

" C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc

"==============================================================================
"Plugins (~sridharp/.vim/plugin)
"==============================================================================
"Tlist
"cscopeMenu
"cscope_win
"MRU
"NERDtree
"conque_term
"colorscheme mirodark

"MRU function keys
"=================
"o          Open file under curser in the MRU window
"t          Open file under curser in new tab
"v          Open file under curser in viewonly mode
"q          quit
"MRU pat    list only the file that matches pat

"NERDtree function keys
"======================
"q          quit
"t          open in a new tab
"T          preveiw in new tab
"i gi       open/preview in horizontal split
"s gs       open/preview in vertical split
"I          List the hidden files(like .vimrc) (toggle)
"F          List files (toggle)
"B          list bookmark (toggle)
"A          maximize/minimize Nerdtree window (toggel)
"o O        open the dir/Recursivly
"x X        close the dir/Recursivly
"<C j>      go to next siblings
"<C k>      go to privious siblings
"r R        refresh current/root

"NERDTree keymap
"=============
nmap <C-\>' :NERDTreeToggle <CR>

"==============================================================================
"Cscope stuffs"
"==============================================================================
"set csprg=~/bin/cscope
cs add $WS_BASE_/$BR_INFO_DIR/cscope.out
set tags=$WS_BASE_/$BR_INFO_DIR/tags
set cscopetag
set tags=$PWD/tags

set csto=0                      "Search cscope first then tags, (1 otherwise)
set cspc=4                      "don't list full file path in cscope results
set cscopeverbose               "show msg when any other cscope db added

set cst
set nocst

"==============================================================================
"Key maps
"==============================================================================
"       0 or s: Find this C symbol
"       1 or g: Find this definition
"       2 or d: Find functions called by this function
"       3 or c: Find functions calling this function
"       4 or t: Find this text string
"       6 or e: Find this egrep pattern
"       7 or f: Find this file
"       8 or i: Find files #including this file
nmap <C-\>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :scs find d <C-R>=expand("<cword>")<CR><CR>

" Tabs
"======
:tab all
nmap <C-\>n :tab split <CR><CR>
nmap <C-\>i :tabs <CR>
nmap <C-\>= :tabnew <CR><CR>
nmap <C-\>- :tabclose <CR><CR>
nmap <End>  :tabn <CR><CR>
nmap <Home> :tabp <CR><CR>
"nmap <PageUp>   :tabn <CR><CR>
"nmap <PageDown> :tabp <CR><CR>

"Mapping to ALT 1 to 9. Do the following to find to key ascii to map
"set showcmd
"go the window in the insert mode then type the key u want
"if u see any value than that value can be mapped
nmap 11 :tabn 1 <CR>
nmap 22 :tabn 2 <CR>
nmap 33 :tabn 3 <CR>
nmap 44 :tabn 4 <CR>
nmap 55 :tabn 5 <CR>
nmap 66 :tabn 6 <CR>
nmap 77 :tabn 7 <CR>
nmap 88 :tabn 8 <CR>
nmap 99 :tabn 9 <CR>

"Tlist keymap
"=============
nmap <C-\>] :TlistToggle<CR><CR>

"MRU keymap
""=============
nmap <C-\>/ :MRU <CR>

"Conque term keymap
""==================
nmap <silent><C-\>1 :ConqueTermTab bash <CR>
nmap <silent><C-\>2 :ConqueTermVSplit bash <CR>

set nocompatible

" Tagbar
"nmap <slient> <F8> :TagbarToggle<CR>

" Stripping white space
" =====================
nmap <C-\>w :StripWhitespace <CR><CR>

"Windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

"ex_mode history-scrollers
"=====================
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

"linux code style
"=====================
let g:linuxsty_patterns = [ "/.*linux-.*/", "/.*driver.*/" ]

"airline
"=====================
let g:airline_powerline_fonts = 1
let g:airline_theme = "cool"
let g:airline_section_b = '%{strftime("%c")}'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"ctrlp.vim
"=====================
"'c'                         the directory of the current file.
"'r'                         the nearest ancestor that contains one of these directories or files:
"                            .git .hg .svn .bzr _darcs
"'a'                         like c, but only if the current working directory outside of CtrlP is
"                            not a direct ancestor of the directory of the current file.
"0 or '' (empty string)      disable this feature.
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" ctrlp-funky
" =====================
nnoremap <C-\>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <C-\>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

"vim-easymotion
"=====================

" Set high visibility for diff mode
"let g:solarized_diffmode="high"
"if &diff
"        colorscheme evening
"endif
"cterm - sets the style
"ctermfg - set the text color
"ctermbg - set the highlighting
"DiffAdd - line was added
"DiffDelete - line was removed
"DiffChange - part of the line was changed (highlights the whole line)
"DiffText - the exact part of the line that changed
"highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
"highlight DiffChange cterm=none ctermfg=black ctermbg=LightGreen gui=none guifg=bg guibg=LightGreen
"highlight DiffText cterm=none ctermfg=black ctermbg=Red gui=none guifg=bg guibg=Red

highlight Search term=reverse cterm=bold ctermbg=grey ctermfg=red

" When using vimdiff or diff mode
highlight DiffAdd term=bold ctermbg=darkgreen ctermfg=white cterm=bold guibg=DarkGreen guifg=White gui=bold
highlight DiffText term=reverse,bold ctermbg=red ctermfg=yellow cterm=bold guibg=DarkRed guifg=yellow gui=bold
highlight DiffChange term=bold ctermbg=black ctermfg=white cterm=bold guibg=Black guifg=White gui=bold
highlight DiffDelete term=none ctermbg=darkblue ctermfg=darkblue cterm=none guibg=DarkBlue guifg=DarkBlue gui=none
if &background == "light"
" Changes when bg=white fg=black
highlight DiffAdd ctermfg=black cterm=bold guibg=green guifg=black
highlight DiffText ctermbg=yellow ctermfg=red cterm=bold guibg=yellow guifg=red
highlight DiffChange ctermbg=none ctermfg=none cterm=bold guibg=white guifg=black
highlight DiffDelete guibg=lightblue guifg=lightblue
endif
" When viewing a diff or patch file
highlight diffRemoved term=bold ctermbg=black ctermfg=red cterm=bold guibg=DarkRed guifg=white gui=none
highlight diffAdded term=bold ctermbg=black ctermfg=green cterm=bold guibg=DarkGreen guifg=white gui=none
highlight diffChanged term=bold ctermbg=black ctermfg=yellow cterm=bold guibg=DarkYellow guifg=white gui=none
highlight diffLine term=bold ctermbg=magenta ctermfg=white cterm=bold guibg=DarkMagenta guifg=white gui=none
highlight diffFile term=bold ctermbg=yellow ctermfg=black cterm=none guibg=DarkYellow guifg=white gui=none
if &background == "light"
" Changes when bg=white fg=black
highlight diffRemoved cterm=none guibg=Red guifg=black
highlight diffAdded cterm=none guibg=Green guifg=black
highlight diffChanged cterm=none guibg=Yellow guifg=black
highlight diffLine cterm=none guibg=Magenta guifg=black
highlight diffFile cterm=none guibg=Yellow guifg=black
endif

"
hi x016_Grey0 ctermfg=16 guifg=#000000 "rgb=0,0,0
hi x017_NavyBlue ctermfg=17 guifg=#00005f "rgb=0,0,95
hi x018_DarkBlue ctermfg=18 guifg=#000087 "rgb=0,0,135
hi x019_Blue3 ctermfg=19 guifg=#0000af "rgb=0,0,175
hi x020_Blue3 ctermfg=20 guifg=#0000d7 "rgb=0,0,215
hi x021_Blue1 ctermfg=21 guifg=#0000ff "rgb=0,0,255
hi x022_DarkGreen ctermfg=22 guifg=#005f00 "rgb=0,95,0
hi x023_DeepSkyBlue4 ctermfg=23 guifg=#005f5f "rgb=0,95,95
hi x024_DeepSkyBlue4 ctermfg=24 guifg=#005f87 "rgb=0,95,135
hi x025_DeepSkyBlue4 ctermfg=25 guifg=#005faf "rgb=0,95,175
hi x026_DodgerBlue3 ctermfg=26 guifg=#005fd7 "rgb=0,95,215
hi x027_DodgerBlue2 ctermfg=27 guifg=#005fff "rgb=0,95,255
hi x028_Green4 ctermfg=28 guifg=#008700 "rgb=0,135,0
hi x029_SpringGreen4 ctermfg=29 guifg=#00875f "rgb=0,135,95
hi x030_Turquoise4 ctermfg=30 guifg=#008787 "rgb=0,135,135
hi x031_DeepSkyBlue3 ctermfg=31 guifg=#0087af "rgb=0,135,175
hi x032_DeepSkyBlue3 ctermfg=32 guifg=#0087d7 "rgb=0,135,215
hi x033_DodgerBlue1 ctermfg=33 guifg=#0087ff "rgb=0,135,255
hi x034_Green3 ctermfg=34 guifg=#00af00 "rgb=0,175,0
hi x035_SpringGreen3 ctermfg=35 guifg=#00af5f "rgb=0,175,95
hi x036_DarkCyan ctermfg=36 guifg=#00af87 "rgb=0,175,135
hi x037_LightSeaGreen ctermfg=37 guifg=#00afaf "rgb=0,175,175
hi x038_DeepSkyBlue2 ctermfg=38 guifg=#00afd7 "rgb=0,175,215
hi x039_DeepSkyBlue1 ctermfg=39 guifg=#00afff "rgb=0,175,255
hi x040_Green3 ctermfg=40 guifg=#00d700 "rgb=0,215,0
hi x041_SpringGreen3 ctermfg=41 guifg=#00d75f "rgb=0,215,95
hi x042_SpringGreen2 ctermfg=42 guifg=#00d787 "rgb=0,215,135
hi x043_Cyan3 ctermfg=43 guifg=#00d7af "rgb=0,215,175
hi x044_DarkTurquoise ctermfg=44 guifg=#00d7d7 "rgb=0,215,215
hi x045_Turquoise2 ctermfg=45 guifg=#00d7ff "rgb=0,215,255
hi x046_Green1 ctermfg=46 guifg=#00ff00 "rgb=0,255,0
hi x047_SpringGreen2 ctermfg=47 guifg=#00ff5f "rgb=0,255,95
hi x048_SpringGreen1 ctermfg=48 guifg=#00ff87 "rgb=0,255,135
hi x049_MediumSpringGreen ctermfg=49 guifg=#00ffaf "rgb=0,255,175
hi x050_Cyan2 ctermfg=50 guifg=#00ffd7 "rgb=0,255,215
hi x051_Cyan1 ctermfg=51 guifg=#00ffff "rgb=0,255,255
hi x052_DarkRed ctermfg=52 guifg=#5f0000 "rgb=95,0,0
hi x053_DeepPink4 ctermfg=53 guifg=#5f005f "rgb=95,0,95
hi x054_Purple4 ctermfg=54 guifg=#5f0087 "rgb=95,0,135
hi x055_Purple4 ctermfg=55 guifg=#5f00af "rgb=95,0,175
hi x056_Purple3 ctermfg=56 guifg=#5f00d7 "rgb=95,0,215
hi x057_BlueViolet ctermfg=57 guifg=#5f00ff "rgb=95,0,255
hi x058_Orange4 ctermfg=58 guifg=#5f5f00 "rgb=95,95,0
hi x059_Grey37 ctermfg=59 guifg=#5f5f5f "rgb=95,95,95
hi x060_MediumPurple4 ctermfg=60 guifg=#5f5f87 "rgb=95,95,135
hi x061_SlateBlue3 ctermfg=61 guifg=#5f5faf "rgb=95,95,175
hi x062_SlateBlue3 ctermfg=62 guifg=#5f5fd7 "rgb=95,95,215
hi x063_RoyalBlue1 ctermfg=63 guifg=#5f5fff "rgb=95,95,255
hi x064_Chartreuse4 ctermfg=64 guifg=#5f8700 "rgb=95,135,0
hi x065_DarkSeaGreen4 ctermfg=65 guifg=#5f875f "rgb=95,135,95
hi x066_PaleTurquoise4 ctermfg=66 guifg=#5f8787 "rgb=95,135,135
hi x067_SteelBlue ctermfg=67 guifg=#5f87af "rgb=95,135,175
hi x068_SteelBlue3 ctermfg=68 guifg=#5f87d7 "rgb=95,135,215
hi x069_CornflowerBlue ctermfg=69 guifg=#5f87ff "rgb=95,135,255
hi x070_Chartreuse3 ctermfg=70 guifg=#5faf00 "rgb=95,175,0
hi x071_DarkSeaGreen4 ctermfg=71 guifg=#5faf5f "rgb=95,175,95
hi x072_CadetBlue ctermfg=72 guifg=#5faf87 "rgb=95,175,135
hi x073_CadetBlue ctermfg=73 guifg=#5fafaf "rgb=95,175,175
hi x074_SkyBlue3 ctermfg=74 guifg=#5fafd7 "rgb=95,175,215
hi x075_SteelBlue1 ctermfg=75 guifg=#5fafff "rgb=95,175,255
hi x076_Chartreuse3 ctermfg=76 guifg=#5fd700 "rgb=95,215,0
hi x077_PaleGreen3 ctermfg=77 guifg=#5fd75f "rgb=95,215,95
hi x078_SeaGreen3 ctermfg=78 guifg=#5fd787 "rgb=95,215,135
hi x079_Aquamarine3 ctermfg=79 guifg=#5fd7af "rgb=95,215,175
hi x080_MediumTurquoise ctermfg=80 guifg=#5fd7d7 "rgb=95,215,215
hi x081_SteelBlue1 ctermfg=81 guifg=#5fd7ff "rgb=95,215,255
hi x082_Chartreuse2 ctermfg=82 guifg=#5fff00 "rgb=95,255,0
hi x083_SeaGreen2 ctermfg=83 guifg=#5fff5f "rgb=95,255,95
hi x084_SeaGreen1 ctermfg=84 guifg=#5fff87 "rgb=95,255,135
hi x085_SeaGreen1 ctermfg=85 guifg=#5fffaf "rgb=95,255,175
hi x086_Aquamarine1 ctermfg=86 guifg=#5fffd7 "rgb=95,255,215
hi x087_DarkSlateGray2 ctermfg=87 guifg=#5fffff "rgb=95,255,255
hi x088_DarkRed ctermfg=88 guifg=#870000 "rgb=135,0,0
hi x089_DeepPink4 ctermfg=89 guifg=#87005f "rgb=135,0,95
hi x090_DarkMagenta ctermfg=90 guifg=#870087 "rgb=135,0,135
hi x091_DarkMagenta ctermfg=91 guifg=#8700af "rgb=135,0,175
hi x092_DarkViolet ctermfg=92 guifg=#8700d7 "rgb=135,0,215
hi x093_Purple ctermfg=93 guifg=#8700ff "rgb=135,0,255
hi x094_Orange4 ctermfg=94 guifg=#875f00 "rgb=135,95,0
hi x095_LightPink4 ctermfg=95 guifg=#875f5f "rgb=135,95,95
hi x096_Plum4 ctermfg=96 guifg=#875f87 "rgb=135,95,135
hi x097_MediumPurple3 ctermfg=97 guifg=#875faf "rgb=135,95,175
hi x098_MediumPurple3 ctermfg=98 guifg=#875fd7 "rgb=135,95,215
hi x099_SlateBlue1 ctermfg=99 guifg=#875fff "rgb=135,95,255
hi x100_Yellow4 ctermfg=100 guifg=#878700 "rgb=135,135,0
hi x101_Wheat4 ctermfg=101 guifg=#87875f "rgb=135,135,95
hi x102_Grey53 ctermfg=102 guifg=#878787 "rgb=135,135,135
hi x103_LightSlateGrey ctermfg=103 guifg=#8787af "rgb=135,135,175
hi x104_MediumPurple ctermfg=104 guifg=#8787d7 "rgb=135,135,215
hi x105_LightSlateBlue ctermfg=105 guifg=#8787ff "rgb=135,135,255
hi x106_Yellow4 ctermfg=106 guifg=#87af00 "rgb=135,175,0
hi x107_DarkOliveGreen3 ctermfg=107 guifg=#87af5f "rgb=135,175,95
hi x108_DarkSeaGreen ctermfg=108 guifg=#87af87 "rgb=135,175,135
hi x109_LightSkyBlue3 ctermfg=109 guifg=#87afaf "rgb=135,175,175
hi x110_LightSkyBlue3 ctermfg=110 guifg=#87afd7 "rgb=135,175,215
hi x111_SkyBlue2 ctermfg=111 guifg=#87afff "rgb=135,175,255
hi x112_Chartreuse2 ctermfg=112 guifg=#87d700 "rgb=135,215,0
hi x113_DarkOliveGreen3 ctermfg=113 guifg=#87d75f "rgb=135,215,95
hi x114_PaleGreen3 ctermfg=114 guifg=#87d787 "rgb=135,215,135
hi x115_DarkSeaGreen3 ctermfg=115 guifg=#87d7af "rgb=135,215,175
hi x116_DarkSlateGray3 ctermfg=116 guifg=#87d7d7 "rgb=135,215,215
hi x117_SkyBlue1 ctermfg=117 guifg=#87d7ff "rgb=135,215,255
hi x118_Chartreuse1 ctermfg=118 guifg=#87ff00 "rgb=135,255,0
hi x119_LightGreen ctermfg=119 guifg=#87ff5f "rgb=135,255,95
hi x120_LightGreen ctermfg=120 guifg=#87ff87 "rgb=135,255,135
hi x121_PaleGreen1 ctermfg=121 guifg=#87ffaf "rgb=135,255,175
hi x122_Aquamarine1 ctermfg=122 guifg=#87ffd7 "rgb=135,255,215
hi x123_DarkSlateGray1 ctermfg=123 guifg=#87ffff "rgb=135,255,255
hi x124_Red3 ctermfg=124 guifg=#af0000 "rgb=175,0,0
hi x125_DeepPink4 ctermfg=125 guifg=#af005f "rgb=175,0,95
hi x126_MediumVioletRed ctermfg=126 guifg=#af0087 "rgb=175,0,135
hi x127_Magenta3 ctermfg=127 guifg=#af00af "rgb=175,0,175
hi x128_DarkViolet ctermfg=128 guifg=#af00d7 "rgb=175,0,215
hi x129_Purple ctermfg=129 guifg=#af00ff "rgb=175,0,255
hi x130_DarkOrange3 ctermfg=130 guifg=#af5f00 "rgb=175,95,0
hi x131_IndianRed ctermfg=131 guifg=#af5f5f "rgb=175,95,95
hi x132_HotPink3 ctermfg=132 guifg=#af5f87 "rgb=175,95,135
hi x133_MediumOrchid3 ctermfg=133 guifg=#af5faf "rgb=175,95,175
hi x134_MediumOrchid ctermfg=134 guifg=#af5fd7 "rgb=175,95,215
hi x135_MediumPurple2 ctermfg=135 guifg=#af5fff "rgb=175,95,255
hi x136_DarkGoldenrod ctermfg=136 guifg=#af8700 "rgb=175,135,0
hi x137_LightSalmon3 ctermfg=137 guifg=#af875f "rgb=175,135,95
hi x138_RosyBrown ctermfg=138 guifg=#af8787 "rgb=175,135,135
hi x139_Grey63 ctermfg=139 guifg=#af87af "rgb=175,135,175
hi x140_MediumPurple2 ctermfg=140 guifg=#af87d7 "rgb=175,135,215
hi x141_MediumPurple1 ctermfg=141 guifg=#af87ff "rgb=175,135,255
hi x142_Gold3 ctermfg=142 guifg=#afaf00 "rgb=175,175,0
hi x143_DarkKhaki ctermfg=143 guifg=#afaf5f "rgb=175,175,95
hi x144_NavajoWhite3 ctermfg=144 guifg=#afaf87 "rgb=175,175,135
hi x145_Grey69 ctermfg=145 guifg=#afafaf "rgb=175,175,175
hi x146_LightSteelBlue3 ctermfg=146 guifg=#afafd7 "rgb=175,175,215
hi x147_LightSteelBlue ctermfg=147 guifg=#afafff "rgb=175,175,255
hi x148_Yellow3 ctermfg=148 guifg=#afd700 "rgb=175,215,0
hi x149_DarkOliveGreen3 ctermfg=149 guifg=#afd75f "rgb=175,215,95
hi x150_DarkSeaGreen3 ctermfg=150 guifg=#afd787 "rgb=175,215,135
hi x151_DarkSeaGreen2 ctermfg=151 guifg=#afd7af "rgb=175,215,175
hi x152_LightCyan3 ctermfg=152 guifg=#afd7d7 "rgb=175,215,215
hi x153_LightSkyBlue1 ctermfg=153 guifg=#afd7ff "rgb=175,215,255
hi x154_GreenYellow ctermfg=154 guifg=#afff00 "rgb=175,255,0
hi x155_DarkOliveGreen2 ctermfg=155 guifg=#afff5f "rgb=175,255,95
hi x156_PaleGreen1 ctermfg=156 guifg=#afff87 "rgb=175,255,135
hi x157_DarkSeaGreen2 ctermfg=157 guifg=#afffaf "rgb=175,255,175
hi x158_DarkSeaGreen1 ctermfg=158 guifg=#afffd7 "rgb=175,255,215
hi x159_PaleTurquoise1 ctermfg=159 guifg=#afffff "rgb=175,255,255
hi x160_Red3 ctermfg=160 guifg=#d70000 "rgb=215,0,0
hi x161_DeepPink3 ctermfg=161 guifg=#d7005f "rgb=215,0,95
hi x162_DeepPink3 ctermfg=162 guifg=#d70087 "rgb=215,0,135
hi x163_Magenta3 ctermfg=163 guifg=#d700af "rgb=215,0,175
hi x164_Magenta3 ctermfg=164 guifg=#d700d7 "rgb=215,0,215
hi x165_Magenta2 ctermfg=165 guifg=#d700ff "rgb=215,0,255
hi x166_DarkOrange3 ctermfg=166 guifg=#d75f00 "rgb=215,95,0
hi x167_IndianRed ctermfg=167 guifg=#d75f5f "rgb=215,95,95
hi x168_HotPink3 ctermfg=168 guifg=#d75f87 "rgb=215,95,135
hi x169_HotPink2 ctermfg=169 guifg=#d75faf "rgb=215,95,175
hi x170_Orchid ctermfg=170 guifg=#d75fd7 "rgb=215,95,215
hi x171_MediumOrchid1 ctermfg=171 guifg=#d75fff "rgb=215,95,255
hi x172_Orange3 ctermfg=172 guifg=#d78700 "rgb=215,135,0
hi x173_LightSalmon3 ctermfg=173 guifg=#d7875f "rgb=215,135,95
hi x174_LightPink3 ctermfg=174 guifg=#d78787 "rgb=215,135,135
hi x175_Pink3 ctermfg=175 guifg=#d787af "rgb=215,135,175
hi x176_Plum3 ctermfg=176 guifg=#d787d7 "rgb=215,135,215
hi x177_Violet ctermfg=177 guifg=#d787ff "rgb=215,135,255
hi x178_Gold3 ctermfg=178 guifg=#d7af00 "rgb=215,175,0
hi x179_LightGoldenrod3 ctermfg=179 guifg=#d7af5f "rgb=215,175,95
hi x180_Tan ctermfg=180 guifg=#d7af87 "rgb=215,175,135
hi x181_MistyRose3 ctermfg=181 guifg=#d7afaf "rgb=215,175,175
hi x182_Thistle3 ctermfg=182 guifg=#d7afd7 "rgb=215,175,215
hi x183_Plum2 ctermfg=183 guifg=#d7afff "rgb=215,175,255
hi x184_Yellow3 ctermfg=184 guifg=#d7d700 "rgb=215,215,0
hi x185_Khaki3 ctermfg=185 guifg=#d7d75f "rgb=215,215,95
hi x186_LightGoldenrod2 ctermfg=186 guifg=#d7d787 "rgb=215,215,135
hi x187_LightYellow3 ctermfg=187 guifg=#d7d7af "rgb=215,215,175
hi x188_Grey84 ctermfg=188 guifg=#d7d7d7 "rgb=215,215,215
hi x189_LightSteelBlue1 ctermfg=189 guifg=#d7d7ff "rgb=215,215,255
hi x190_Yellow2 ctermfg=190 guifg=#d7ff00 "rgb=215,255,0
hi x191_DarkOliveGreen1 ctermfg=191 guifg=#d7ff5f "rgb=215,255,95
hi x192_DarkOliveGreen1 ctermfg=192 guifg=#d7ff87 "rgb=215,255,135
hi x193_DarkSeaGreen1 ctermfg=193 guifg=#d7ffaf "rgb=215,255,175
hi x194_Honeydew2 ctermfg=194 guifg=#d7ffd7 "rgb=215,255,215
hi x195_LightCyan1 ctermfg=195 guifg=#d7ffff "rgb=215,255,255
hi x196_Red1 ctermfg=196 guifg=#ff0000 "rgb=255,0,0
hi x197_DeepPink2 ctermfg=197 guifg=#ff005f "rgb=255,0,95
hi x198_DeepPink1 ctermfg=198 guifg=#ff0087 "rgb=255,0,135
hi x199_DeepPink1 ctermfg=199 guifg=#ff00af "rgb=255,0,175
hi x200_Magenta2 ctermfg=200 guifg=#ff00d7 "rgb=255,0,215
hi x201_Magenta1 ctermfg=201 guifg=#ff00ff "rgb=255,0,255
hi x202_OrangeRed1 ctermfg=202 guifg=#ff5f00 "rgb=255,95,0
hi x203_IndianRed1 ctermfg=203 guifg=#ff5f5f "rgb=255,95,95
hi x204_IndianRed1 ctermfg=204 guifg=#ff5f87 "rgb=255,95,135
hi x205_HotPink ctermfg=205 guifg=#ff5faf "rgb=255,95,175
hi x206_HotPink ctermfg=206 guifg=#ff5fd7 "rgb=255,95,215
hi x207_MediumOrchid1 ctermfg=207 guifg=#ff5fff "rgb=255,95,255
hi x208_DarkOrange ctermfg=208 guifg=#ff8700 "rgb=255,135,0
hi x209_Salmon1 ctermfg=209 guifg=#ff875f "rgb=255,135,95
hi x210_LightCoral ctermfg=210 guifg=#ff8787 "rgb=255,135,135
hi x211_PaleVioletRed1 ctermfg=211 guifg=#ff87af "rgb=255,135,175
hi x212_Orchid2 ctermfg=212 guifg=#ff87d7 "rgb=255,135,215
hi x213_Orchid1 ctermfg=213 guifg=#ff87ff "rgb=255,135,255
hi x214_Orange1 ctermfg=214 guifg=#ffaf00 "rgb=255,175,0
hi x215_SandyBrown ctermfg=215 guifg=#ffaf5f "rgb=255,175,95
hi x216_LightSalmon1 ctermfg=216 guifg=#ffaf87 "rgb=255,175,135
hi x217_LightPink1 ctermfg=217 guifg=#ffafaf "rgb=255,175,175
hi x218_Pink1 ctermfg=218 guifg=#ffafd7 "rgb=255,175,215
hi x219_Plum1 ctermfg=219 guifg=#ffafff "rgb=255,175,255
hi x220_Gold1 ctermfg=220 guifg=#ffd700 "rgb=255,215,0
hi x221_LightGoldenrod2 ctermfg=221 guifg=#ffd75f "rgb=255,215,95
hi x222_LightGoldenrod2 ctermfg=222 guifg=#ffd787 "rgb=255,215,135
hi x223_NavajoWhite1 ctermfg=223 guifg=#ffd7af "rgb=255,215,175
hi x224_MistyRose1 ctermfg=224 guifg=#ffd7d7 "rgb=255,215,215
hi x225_Thistle1 ctermfg=225 guifg=#ffd7ff "rgb=255,215,255
hi x226_Yellow1 ctermfg=226 guifg=#ffff00 "rgb=255,255,0
hi x227_LightGoldenrod1 ctermfg=227 guifg=#ffff5f "rgb=255,255,95
hi x228_Khaki1 ctermfg=228 guifg=#ffff87 "rgb=255,255,135
hi x229_Wheat1 ctermfg=229 guifg=#ffffaf "rgb=255,255,175
hi x230_Cornsilk1 ctermfg=230 guifg=#ffffd7 "rgb=255,255,215
hi x231_Grey100 ctermfg=231 guifg=#ffffff "rgb=255,255,255
hi x232_Grey3 ctermfg=232 guifg=#080808 "rgb=8,8,8
hi x233_Grey7 ctermfg=233 guifg=#121212 "rgb=18,18,18
hi x234_Grey11 ctermfg=234 guifg=#1c1c1c "rgb=28,28,28
hi x235_Grey15 ctermfg=235 guifg=#262626 "rgb=38,38,38
hi x236_Grey19 ctermfg=236 guifg=#303030 "rgb=48,48,48
hi x237_Grey23 ctermfg=237 guifg=#3a3a3a "rgb=58,58,58
hi x238_Grey27 ctermfg=238 guifg=#444444 "rgb=68,68,68
hi x239_Grey30 ctermfg=239 guifg=#4e4e4e "rgb=78,78,78
hi x240_Grey35 ctermfg=240 guifg=#585858 "rgb=88,88,88
hi x241_Grey39 ctermfg=241 guifg=#626262 "rgb=98,98,98
hi x242_Grey42 ctermfg=242 guifg=#6c6c6c "rgb=108,108,108
hi x243_Grey46 ctermfg=243 guifg=#767676 "rgb=118,118,118
hi x244_Grey50 ctermfg=244 guifg=#808080 "rgb=128,128,128
hi x245_Grey54 ctermfg=245 guifg=#8a8a8a "rgb=138,138,138
hi x246_Grey58 ctermfg=246 guifg=#949494 "rgb=148,148,148
hi x247_Grey62 ctermfg=247 guifg=#9e9e9e "rgb=158,158,158
hi x248_Grey66 ctermfg=248 guifg=#a8a8a8 "rgb=168,168,168
hi x249_Grey70 ctermfg=249 guifg=#b2b2b2 "rgb=178,178,178
hi x250_Grey74 ctermfg=250 guifg=#bcbcbc "rgb=188,188,188
hi x251_Grey78 ctermfg=251 guifg=#c6c6c6 "rgb=198,198,198
hi x252_Grey82 ctermfg=252 guifg=#d0d0d0 "rgb=208,208,208
hi x253_Grey85 ctermfg=253 guifg=#dadada "rgb=218,218,218
hi x254_Grey89 ctermfg=254 guifg=#e4e4e4 "rgb=228,228,228
hi x255_Grey93 ctermfg=255 guifg=#eeeeee "rgb=238,238,238
