" ~/.vimrc
" por Gustavo Gattino
" .vimrc KISS

" VISUAL
"colorscheme vimbrant           " usa o esquema vimbrant

set background=dark
"set background=light
colorscheme solarized

syntax on                       " ativa a syntax
set nu                          " coloca numero de linhas
set autoindent                  " recua a linha para o mesmo nivel da de cima
set shiftwidth=4                " muda o tab p 4 espaco e nao 8
set expandtab                   " transforma os tabs em espacos
set sm                          " mostra o par dos ( ) { } [ ]
set backspace=eol,start,indent  " backspc apaga linha
set title                       " coloca titulo na barra
set showmode                    " mostra o modo atual
set scrolljump=5                " linhas que pulam quando o cursor chega ao fim do arquivo
set scrolloff=3                 " minimo de linhas acima do cursor

" cor do numero de linhas
highlight LineNr ctermfg=green  
highlight LineNr ctermbg=black

" fechamento automático de parenteses e semelhantes:
inoremap ( ()<esc>i 
inoremap { {}<esc>i 
inoremap [ []<esc>i
