function! neoformat#formatters#jsonc#enabled() abort
    return ['prettierd', 'prettier', 'denofmt']
endfunction

function! neoformat#formatters#jsonc#prettier() abort
    return {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin-filepath', '"%:p"'],
        \ 'stdin': 1,
        \ 'try_node_exe': 1,
        \ }
endfunction

function! neoformat#formatters#jsonc#prettierd() abort
    return {
        \ 'exe': 'prettierd',
        \ 'args': ['"%:p"'],
        \ 'stdin': 1,
        \ }
endfunction

function! neoformat#formatters#jsonc#denofmt() abort
    return {
        \ 'exe': 'deno',
        \ 'args': ['fmt','--ext','jsonc','-'],
        \ 'stdin': 1,
        \ }
endfunction
