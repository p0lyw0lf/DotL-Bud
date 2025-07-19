let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/DotL-Bud/dotl-bud
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +0 src/dotl_bud/__about__.py
badd +1 src/dotl_bud/__init__.py
badd +5 src/dotl_bud/__main__.py
badd +8 src/dotl_bud/command_parser.py
badd +6 src/dotl_bud/command_scheduler.py
badd +6 src/dotl_bud/doclite.py
badd +3 src/dotl_bud/filter/__init__.py
badd +7 src/dotl_bud/modules/dice.py
badd +2 src/dotl_bud/modules/help.py
badd +7 src/dotl_bud/modules/memes.py
badd +0 src/dotl_bud/modules/misc.py
badd +1 src/dotl_bud/modules/permissions.py
badd +0 src/dotl_bud/modules/role_manager.py
badd +0 src/dotl_bud/modules/rss_checker.py
badd +7 src/dotl_bud/modules/shell.py
badd +1 src/dotl_bud/modules/variables.py
badd +43 src/dotl_bud/profanity_filter.py
badd +19 src/dotl_bud/utils.py
argglobal
%argdel
$argadd src/dotl_bud/__about__.py
$argadd src/dotl_bud/__init__.py
$argadd src/dotl_bud/__main__.py
$argadd src/dotl_bud/command_parser.py
$argadd src/dotl_bud/command_scheduler.py
$argadd src/dotl_bud/doclite.py
$argadd src/dotl_bud/filter/__init__.py
$argadd src/dotl_bud/modules/dice.py
$argadd src/dotl_bud/modules/help.py
$argadd src/dotl_bud/modules/memes.py
$argadd src/dotl_bud/modules/misc.py
$argadd src/dotl_bud/modules/permissions.py
$argadd src/dotl_bud/modules/role_manager.py
$argadd src/dotl_bud/modules/rss_checker.py
$argadd src/dotl_bud/modules/shell.py
$argadd src/dotl_bud/modules/variables.py
$argadd src/dotl_bud/profanity_filter.py
$argadd src/dotl_bud/utils.py
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit src/dotl_bud/__main__.py
argglobal
3argu
balt src/dotl_bud/__about__.py
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 38 - ((37 * winheight(0) + 19) / 38)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 38
normal! 0
tabnext
edit src/dotl_bud/modules/misc.py
argglobal
11argu
balt src/dotl_bud/__about__.py
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 38 - ((37 * winheight(0) + 19) / 38)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 38
normal! 0
tabnext
edit src/dotl_bud/modules/role_manager.py
argglobal
13argu
balt src/dotl_bud/__about__.py
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 19) / 38)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
edit src/dotl_bud/modules/rss_checker.py
argglobal
14argu
balt src/dotl_bud/__about__.py
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 19) / 38)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext
edit src/dotl_bud/modules/shell.py
argglobal
15argu
balt src/dotl_bud/__about__.py
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 7 - ((6 * winheight(0) + 19) / 38)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 7
normal! 037|
tabnext
edit src/dotl_bud/profanity_filter.py
argglobal
17argu
balt src/dotl_bud/__about__.py
setlocal foldmethod=manual
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
silent! normal! zE
let &fdl = &fdl
let s:l = 38 - ((37 * winheight(0) + 19) / 38)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 38
normal! 056|
tabnext 2
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
