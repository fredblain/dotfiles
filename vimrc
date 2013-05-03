set nocompatible                                  " désactivation de la compatibilité avec vi

colorscheme desert                                " couleur
syntax enable

" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle..."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    Bundle 'gmarik/vundle'
    " nerdtree
    Bundle 'scrooloose/nerdtree'
    " syntastic
    Bundle 'scrooloose/syntastic'
    " vim surround
    Bundle 'tpope/vim-surround'
    " gist
    Bundle 'mattn/gist-vim'
    " TAGS
    " easytags
    Bundle 'xolox/vim-easytags'
    " tagbar
    Bundle 'majutsushi/tagbar'
    let g:tagbar_right = 1
    " snipMate
    Bundle 'msanders/snipmate.vim'
    if iCanHazVundle == 0
        echo "Installing Bundles..."
        echo ""
        :BundleInstall
    endif

set mouse=a                                       " active l'utilisation et la navigation au curseur
set number                                        " numérotation des lignes
set ignorecase                                    " ne pas prendre en compte la casse pour les recherches
set autoindent                                    " indentation automatique avancée
set smartindent cinoptions=(0,j1                  " indentation plus intelligente
set laststatus=2                                  " ajoute une barre de status
set backspace=indent,eol,start                    " autorisation du retour arrière
set history=500                                   " historique de 500 commandes
set ruler                                         " affiche la position courante au sein du fichier
set showcmd                                       " affiche la commande en cours
set shiftwidth=2                                  " nombre de tabulation pour l'indentation
set tabstop=4					                  " nombre d'espace pour une tabulation
set smarttab expandtab
set showmatch                                     " vérification présence ([ ou { à la frappe de )] ou }

set cursorline                                    " afficher la ligne courante
hi CursorLine guibg=#4d4d4d                       " couleur de fond pour la ligne courante

filetype plugin indent on                         " détection automatique du type de fichier
autocmd FileType text setlocal textwidth=80       " les fichiers de type .txt sont limites à 80 caractères par ligne
set wrap                                          " retour à ligne automatique
set lbr                                           " force le retour à la ligne pour un mot
set fileformats=unix,mac,dos                      " gestion des retours chariot en fonction du type de fichier

set foldcolumn=2                                  " repère visuel pour les folds

set incsearch                                     " recherche incrémentale
set hlsearch                                      " surligne les résultats de la recherche

set nolist					                      " on n'affiche pas les caractères non imprimables
set listchars=eol:¶,tab:..,trail:~		          " paramétrage des caractères non imprimables au cas où l'on souhaiterait les afficher

autocmd BufWrite * silent! %s/[\r \t]\+$//        " Supprime les espaces en fin de ligne avant de sauver

" always jump to last edit position when opening a file
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8 bomb
  set fileencodings=ucs-bom,utf-8,default,latin1
endif

""""""""""""""""""""""""""""""""""""""""""""""""""
" Mapping pour vérification intégrité format XML
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <F6> :%!xmllint --format --recover -<CR>

""""""""""""""""""""""""""""
"Mapping pour lancer Astyle
""""""""""""""""""""""""""""
nnoremap <silent> <F5> :%!astyle <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
"Mapping pour désactiver le surlignage des
"résultats d'une recherche
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <C-N> :noh<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
"Mapping pour naviguer dans les lignes coupées
""""""""""""""""""""""""""""""""""""""""""""""""""
map <A-DOWN> gj
map <A-UP> gk
imap <A-UP> <ESC>gki
imap <A-DOWN> <ESC>gkj

""""""""""""""""""""""""""""""""""""""""""""""""""
"Repositionner le curseur à l'emplacement de la
"dernière édition
""""""""""""""""""""""""""""""""""""""""""""""""""
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

""""""""""""""""""""""""""""""""""""""""""""""""""
"Chargement des types de fichiers
""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufEnter *.txt set filetype=text             " chargement du type de fichier pour le format txt
autocmd BufEnter *xliff set filetype=xml             " chargement du type de fichier pour le format xml/xliff

""""""""""""""""""""""""""""""""""""""""""""""""""
"Omni-completion par CTRL-X_CTRL-O
""""""""""""""""""""""""""""""""""""""""""""""""""
au filetype html        set omnifunc=htmlcomplete#CompleteTags
au filetype css         set omnifunc=csscomplete#CompleteCSS
au filetype javascript  set omnifunc=javascriptcomplete#CompleteJS
au filetype c           set omnifunc=ccomplete#Complete
au filetype php         set omnifunc=phpcomplete#CompletePHP
au filetype ruby        set omnifunc=rubycomplete#Complete
au filetype sql         set omnifunc=sqlcomplete#Complete
au filetype python      set omnifunc=pythoncomplete#Complete
au filetype xml         set omnifunc=xmlcomplete#CompleteTags

""""""""""""""""""""""""""""""""""""""""""""""""""
"Personnalisation de la barre de statut
""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=\ \ '%t%m%r%h%w'\ (%L\ lines)\ [FORMAT=%{&ff}]\ [ENCODING:\%{&fileencoding},\ ascii=\%03.3b\ hex=\%02.2B]\ [POS=%04l,%04v\ %p%%]

""""""""""""""""""""""""""""""""""""""""""""""""""
"Mapping pour l'activation de l'explorateur
"système
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <F9> :NERDTreeFind <CR>
"let loaded_nerd_tree = 1	" turn off
"let NERDTreeShowHidden = 0	" display hidden file on start
"let NERDTreeMirror = 1

""""""""""""""""""""""""""""""""""""""""""""""""""
"Mapping et configuration pour la liste des tags
""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <F8> :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
"Map pour se déplacer dans les onglets
""""""""""""""""""""""""""""""""""""""""""""""""""
" left to right
map <tab> gt
" right to left
map <S-tab> gT

""""""""""""""""""""""""""""""""""""""""""""""""""
"Mapping pour insérer la date du jour
""""""""""""""""""""""""""""""""""""""""""""""""""
imap \date  <C-R>=strftime("%d/%m/%Y")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
"Mapping pour copier, couper, coller
"et sélectionner
""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-x> "+x
map <C-c> "+y
map <C-p> "+gP
map <C-a> ggVG

""""""""""""""""""""""""""""""""""""""""""""""""""
"Nom du fichier en cours dans l'onglet pour Vim
""""""""""""""""""""""""""""""""""""""""""""""""""
function! ShortTabLine()
    let ret = ''
    for i in range(tabpagenr('$'))
	"Select the color group for highlighting active tab
	if i + 1 == tabpagenr()
	    let ret .= '%#errorMsg#'
	else
	    let ret .= '%#TabLine#'
	endif

	"Find the buffername for the tablabel
	let buflist = tabpagebuflist(i+1)
	let winnr = tabpagewinnr(i+1)
	let buffername = bufname(buflist[winnr - 1])
	let filename = fnamemodify(buffername, ':t')
	"Check if there is no name
	if filename == ''
	    let filename = 'noname'
	endif
	"Only show the first 18 letters of the name and
	".. if the filename is more than 20 letters long
	if strlen(filename) >= 8
	    let ret .= '['.filename[0:17].'..]'
	else
	    let ret .= '['.filename.']'
	endif
    endfor

    "After the last tab fill with TabLineFill and reset tab page #
    let ret .= '%#TabLineFill#%T'
    return ret
endfunction

set tabline=%!ShortTabLine()

""""""""""""""""""""""""""""""""""""""""""""""""""
"Modification de l'affichage des replis
""""""""""""""""""""""""""""""""""""""""""""""""""
function! MyFoldFunction()
    let line = getline(v:foldstart)
    "Cleanup unwanted things in first line
    let sub = substitute(line, '/\*\|\*/\|^\s+', '', 'g')
    "Calculate lines in folded text
    let lines = v:foldend - v:foldstart + 1
    return v:folddashes.sub.' {...'.lines.' Lines...}'
endfunction

set foldtext=MyFoldFunction()

""""""""""""""""""""""""""""""""""""""""""""""""""
"Couleur pour les templates
""""""""""""""""""""""""""""""""""""""""""""""""""
hi def link Todo TODO
syn keyword Todo TODO FIXME XXX DEBUG README

