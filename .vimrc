set nocompatible
" source $VIMRUNTIME/vimrc_example.vim
behave xterm

set bs=1
set comments=sr:/*,mb:*,mb:**,el:*/,://,b:#,:%,:XCOMM,n:>,fb:-
set formatoptions=tcql
set nobackup
set nowrap
set ruler
set shortmess=aT
set ul=0
set wildmenu
set wildmode=list:longest
set vb
set matchpairs+=<:>
set colorcolumn=81

map  <F2> o/*<CR><ESC>79a*<ESC>o*/<CR><ESC>
map! <F2>  /*<CR><ESC>79a*<ESC>o*/<CR><ESC>

map  <F3> o/<ESC>71a/<ESC>o//<ESC>68a <ESC>a//<ESC>yypkVkyjjpddpo<ESC>
map! <F3>  /<ESC>71a/<ESC>o//<ESC>68a <ESC>a//<ESC>yypkVkyjjpddpo<ESC>

map  <F4> o/<ESC>78a/<ESC>^
map! <F4>  /<ESC>78a/<ESC>^

map  <F5> :nohlsearch<CR>

if has ("gui_running")

	" For Unix:
	set number
	set guifont=Bitstream\ Vera\ Sans\ Mono\ 14
elseif &term == "linux" || &term == "xterm"
	set t_Co=8
	set t_Sf=[3%dm
	set t_Sb=[4%dm
endif

"
" Windows can't deal with these characters.
"

if has ("gui_running") || &term != "win32"
	set listchars=tab:»·,trail:·
endif

syntax on

hi Comment    cterm=NONE ctermfg=6 gui=NONE    guifg=#828482
hi Constant   cterm=NONE ctermfg=6 gui=NONE    guifg=#828482
hi Special    cterm=NONE ctermfg=2 gui=NONE    guifg=#0000ff
hi Identifier cterm=NONE ctermfg=2 gui=NONE    guifg=#0000ff
hi Statement  cterm=NONE ctermfg=2 gui=NONE    guifg=#0000ff
hi PreProc    cterm=NONE ctermfg=2 gui=NONE    guifg=#0000ff
hi Type       cterm=NONE ctermfg=2 gui=NONE    guifg=#0000ff
hi Ignore     cterm=NONE ctermfg=1 gui=NONE    guifg=#ff0000
hi NonText    cterm=NONE ctermfg=1 gui=NONE    guifg=#6495ed
hi Visual                          gui=reverse guifg=#da70d6

" De-uglification for C and C++
hi Structure  cterm=NONE ctermfg=2 gui=NONE guifg=#0000ff

" The stupid system vimrc is overriding my formatoptions (which breaks <F2> and
" <F3>).

" Apparently also only for Unix.
" au! cprog FileType

" information flow
digraph /l  8467  " ℓ
digraph [=  8849  " ⊑
digraph ]=  8850  " ⊒
digraph [_  8847  " ⊏
digraph ]_  8848  " ⊐
digraph [^  8851  " ⊔
digraph [U  8852  " ⊓
digraph (>  8829  " ≽
digraph (<  8828  " ≼
digraph /<  8928  " ⋠
digraph />  8929  " ⋡
digraph ~=  8776  " ≈
digraph /~  8777  " ≉
digraph ~>  8669  " ⇝
digraph >>  8608  " ↠
digraph /[  8930  " ⋢
digraph /]  8931  " ⋣


" PL
digraph [[  10214 " ⟦
digraph ]]  10215 " ⟧
digraph \|- 8866  " ⊢
digraph \|= 8872  " ⊨
digraph _\| 8869  " ⊥
digraph \|_ 8869  " ⊥
digraph TT  8868  " ⊤


" other math
digraph ox  8855  " ⊗
digraph o+  8853  " ⊕
digraph \|> 8614  " ↦
digraph /=  8800  " ≠
digraph /\  8743  " ∧
digraph \/  8744  " ∨
digraph ~~  0172  " ¬


digraph /(  8713   " ∉
digraph UU  8746   " ∪
digraph U^  8745   " ∩
digraph xx  215    " × (times sign/cartesian product)
digraph (_  8838   " ⊆
digraph )_  8839   " ⊇
digraph \\  8726   " ∖ (set minus)
digraph \|\| 10072 " ❘ (vertical bar)
digraph ^^  770    "  ̂ (add hat to previous character)

" mathbb
digraph NN  8469   " ℕ
digraph ZZ  8484   " ℤ
digraph RR  8477   " ℝ

" misc
digraph sq 8730 " √
digraph <> 8822 " ≶

au Syntax tex syn region texZone start="\\begin{ocaml}" end="\\end{ocaml}" 
au Syntax tex syn region texZone start="\\code{" end="}" 

set ts=4 sw=4 ai et
" au BufNewFile,BufRead *.ts set ts=2 sw=2 ai et

set spelllang=en_us

filetype plugin on
syntax sync fromstart
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
