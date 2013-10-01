if exists('g:loded_buf_case_sensitive')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim




command! -nargs=0 BufCaseSensitiveDisable :let g:buf_case_sensitive_is_disable = 1
command! -nargs=0 BufCaseSensitiveEnable  :unlet! g:buf_case_sensitive_is_disable




augroup buf_case_sensitive.vim
    autocmd!
    autocmd BufLeave * call s:save_case_sensitive()
    autocmd BufEnter * call s:change_case_sensitive()
augroup end


function! s:save_case_sensitive()
    let b:ignorecase = &g:ignorecase
    let b:smartcase  = &g:smartcase
endfunction

function! s:change_case_sensitive()
    if get(g:, 'buf_case_sensitive_is_disable', 0) == 1
        return
    endif


    let &g:ignorecase = get(b:, 'ignorecase', &g:ignorecase)
    let &g:smartcase  = get(b:, 'smartcase',  &g:smartcase)
endfunction


function! s:ignorecase_to_string(ignorecase)
    return a:ignorecase == 1 ? 'ignorecase' : 'noignorecase'
endfunction




let &cpo = s:save_cpo
unlet s:save_cpo

let g:loded_buf_case_sensitive = 1
