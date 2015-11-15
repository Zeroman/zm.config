""" Setting
" set guicursor+=a:blinkon0
if has('gui_gtk')
  " set guifont=VL\ Gothic\ Italic\ 18
  " set guifont=Bitstream\ Vera\ Sans\ Mono\ Oblique\ 16
  set guifont=CosmicSansNeueMono\ Italic\ 16
else
  set guifont=-misc-fixed-medium-r-semicondensed--13-120-*-*-c-60-iso10646-1
endif
set guioptions-=m
set guioptions-=T
set t_vb=


set guitablabel=%N/\ %t\ %M

""" Autocommands
au VimEnter * call MapAlt_To_Table()

""" Functions
""""  MapAlt_To_Table
function! MapAlt_To_Table()
    for i in range(1, 9)
        exe "map <A-".i."> ".i."gt"
        exe "imap <A-".i."> <esc>".i."gt"
        " exe "map <A-".i."> <ESC>:b ".i."<CR>"
    endfor
endfunction



"" vim:fdm=expr:fdl=0
"" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
