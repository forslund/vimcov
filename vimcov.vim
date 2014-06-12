" Based on Gautier DI FOLCO's vcov.vim found in
" https://groups.google.com/forum/#!msg/vim_use/tk9sG714b3I/LyMnXOQAqpMJ
"
" Modified and prettified by Åke Forslund <ake.forslund@gmail.com>

hi gcovCovered ctermbg=2
hi gcovNotCovered ctermbg=1

function! Setcov(filename)
exe ":sign unplace *"
for line in readfile(a:filename)
let d = split(line, ':')
let c = substitute(d[0], " *", "", "")
let l = substitute(d[1], " *", "", "")
if c >= 100
let c = '*'
endif

if '-' != c && c !~ '#'
exe ":sign define c" . c . " text=" . c . " texthl=gcovCovered"
exe ":sign place " . l . " line=" . l . " name=c" . c . " file=" . expand("%:p")
elseif c =~ '#'
exe ":sign define cd text=# texthl=gcovNotCovered"
exe ":sign place " . l . " line=" . l . " name=cd file=" . expand("%:p")
endif
endfor
endfunction

function! Unsetcov()
exe ":sign unplace *"
endfunction

map <F11> :call Setcov(expand(@%).".gcov")<cr>
map <F12> :call Unsetcov()<cr>
