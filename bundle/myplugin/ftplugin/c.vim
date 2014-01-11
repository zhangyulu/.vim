"auto complete {}
if &filetype == "c" || &filetype == "cpp" || &filetype == "h" || &filetype == "cc" || &filetype == "hpp"
    inoremap <buffer> {<CR> {<CR>}<Esc>O
endif
