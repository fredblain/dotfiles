""""""""""""""""""""""""""""""""""""""""""""""""""
"Diverses options
""""""""""""""""""""""""""""""""""""""""""""""""""

set mouse=a
set fu                                            " active le moe fullscreen
set backup		                          " active la sauvegarde automatique
set nocompatible                                  " désactivation de la compatibilité avec vi

colorscheme desert                               " couleur
syntax enable                                     " activation de la coloration syntaxique

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
set tabstop=4					  " nombre d'espace pour une tabulation
set smarttab expandtab
set showmatch                                     " vérification présence ([ ou { à la frappe de )] ou }

set cursorline                                    " afficher la ligne courante
hi CursorLine guibg=#4d4d4d                       " couleur de fond pour la ligne courante

filetype plugin indent on                         " détection automatique du type de fichier
autocmd FileType text setlocal textwidth=80       " les fichiers de type .txt sont limites à 80 caractères par ligne
set fileformats=unix,mac,dos                      " gestion des retours chariot en fonction du type de fichier
"set viewdir=/home/blain/.vim/saveview/           " répertoire pour sauvegarder les vues, utiles pour les replis manuels

set foldcolumn=2                                  " repère visuel pour les folds

set incsearch                                     " recherche incrémentale
set hlsearch                                      " surligne les résultats de la recherche

set nolist					  " on n'affiche pas les caractères non imprimables
set listchars=eol:¶,tab:..,trail:~		  " paramétrage des caractères non imprimables au cas où l'on souhaiterait les afficher

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

nnoremap <silent> <F6> :%!xmllint --format --recover -<CR>
nnoremap <silent> <F5> :%!astyle <CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
"Backup dans ~/.vim/backup
""""""""""""""""""""""""""""""""""""""""""""""""""
if filewritable(expand("$HOME/.vim/backup")) == 2
    " comme le répertoire est accessible en écriture,
    " on va l'utiliser.
	set backupdir=$HOME/.vim/backup
else
	if has("unix") || has("win32unix")
        " C'est un système compatible UNIX, on
        " va créer le répertoire et l'utiliser.
		call system("mkdir $HOME/.vim/backup -p")
		set backupdir=$HOME/.vim/backup
	endif
endif

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
set statusline=\ \ '%t%m%r%h%w'\ (%L\ lines)\ [FORMAT=%{&ff}]\ [ENCODING:\%{&fileencoding},\ ascii=\%03.3b\ hex=\%02.2B]\ [POS=%04l,%04v\ %p%%]\ \ \ [TAG=%{Tlist_Get_Tagname_By_Line()}]



""""""""""""""""""""""""""""""""""""""""""""""""""
"Mapping pour l'activation de l'explorateur
"système
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <F9> :NERDTree ${PWD}<CR>
"let loaded_nerd_tree = 1	" turn off
let NERDTreeShowHidden = 0	" display hidden file on start
"let NERDTreeMirror = 1


""""""""""""""""""""""""""""""""""""""""""""""""""
"Mapping et configuration pour la liste des tags
""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Ctags_Cmd = '/usr/bin/ctags'	" implémentation de ctags, nécessaire pour le plugin 'taglist'
let Tlist_Exit_OnlyWindow = 1		" vim se ferme si il reste uniquement la fenêtre des tags
let Tlist_Process_File_Always = 1	" activation permanente du plugin pour la barre de statut
let Tlist_Use_Right_Window = 1		" affiche les tags sur le côté droit de l'écran
let Tlist_File_Fold_Auto_Close = 1	" referme automatiquement les fichiers inactifs
let Tlist_Auto_Open = 1			" ouvre automatiquement la fenetre des tags au lancement de (G)Vim
let Tlist_Use_SingleClick = 1           " single left mouse click to jump to tags


""""""""""""""""""""""""""""""""""""""""""""""""""
"Sauvegarde automatique des vues, utiles pour les
"replis manuels
""""""""""""""""""""""""""""""""""""""""""""""""""
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview


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
"Dictionnaire français
"Liste des propositions par CTRL-X_CTRL-K
""""""""""""""""""""""""""""""""""""""""""""""""""
set dictionary+=/usr/share/dict/french
set dictionary+=/usr/share/dict/american-english
set dictionary+=/usr/share/dict/british-english


""""""""""""""""""""""""""""""""""""""""""""""""""
"Correction orthographique
"Liste des propositions par CTRL-X_s
""""""""""""""""""""""""""""""""""""""""""""""""""
set spellsuggest=5                                   " on affiche uniquement les 5 premières propositions
autocmd BufEnter *.txt set spell spelllang=fr,en     " correction orthographique dans les fichiers textes

" pas de correction orthographique par défaut
set nospell

" automatique pour les fichiers .txt et .tex
augroup filetypedetect
  au BufNewFile,BufRead *.txt setlocal spell spelllang=en
  au BufNewFile,BufRead *.tex setlocal spell spelllang=en
augroup END

" painless spell checking
" for French
function s:spell_fr()
    if !exists("s:spell_check") || s:spell_check == 0
        echo "Spell checking ** FRENCH ON **"
        let s:spell_check = 1
        setlocal spell spelllang=fr
    else
        echo "Spell checking ** FRENCH OFF **"
        let s:spell_check = 0
        setlocal spell spelllang=
    endif
endfunction
" mapping
noremap  <F10>        :call <SID>spell_fr()<CR>
inoremap <F10>   <C-o>:call <SID>spell_fr()<CR>
vnoremap <F10>   <C-o>:call <SID>spell_fr()<CR>

" for English
function s:spell_en()
    if !exists("s:spell_check") || s:spell_check == 0
        echo "Spell checking ** ENGLISH ON **"
        let s:spell_check = 1
        setlocal spell spelllang=en
    else
        echo "Spell checking ** ENGLISH OFF **"
        let s:spell_check = 0
        setlocal spell spelllang=
    endif
endfunction
" mapping
noremap  <S-F10>      :call <SID>spell_en()<CR>
inoremap <S-F10> <C-o>:call <SID>spell_en()<CR>
vnoremap <S-F10> <C-o>:call <SID>spell_en()<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""
"Infos-Bulles
""""""""""""""""""""""""""""""""""""""""""""""""""
function! FoldSpellBalloon()
    let foldStart = foldclosed(v:beval_lnum)
    let foldEnd = foldclosedend(v:beval_lnum)
    let lines = []
    "Detect if we are in a fold
    if foldStart < 0
	"Detect if we are on a misspelled word
	let lines = spellsuggest(spellbadword(v:beval_text)[0], 5, 0)
    else
	"We are in a fold
	let numLines = foldEnd - foldStart + 1
	"If we have too many lines in fold, show only the first 14
	"and the last 14 lines
	if(numLines > 31)
	    let lines = getline(foldStart, foldStart + 14)
	    let lines += ['-- Snipped ' . (numLines - 30) . ' lines --']
	    let lines += getline(foldEnd - 14, foldEnd)
	else
	    "Less than 30 lines, lets show all of them
	    let lines = getline(foldStart, foldEnd)
	endif
    endif
    "Return result
    return join(lines, has("balloon_multiline") ? "\n" : " ")
endfunction

"set balloonexpr=FoldSpellBalloon()
"set ballooneval



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
"Poser une marque visible avec F7
""""""""""""""""""""""""""""""""""""""""""""""""""
hi Mark guibg=indianred guifg=white gui=bold cterm=bold ctermfg=7 ctermbg=1
map <F7> :exe 'sign place 001 name=mark line='.line(".").' buffer='.winbufnr(0)<CR>
map <C-F7> :sign unplace<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
"Couleur pour les templates
""""""""""""""""""""""""""""""""""""""""""""""""""
hi def link Todo TODO
syn keyword Todo TODO FIXME XXX DEBUG


""""""""""""""""""""
" LATEX
""""""""""""""""""""

 " IMPORTANT: grep will sometimes skip displaying the file name if you
 " search in a singe file. This will confuse Latex-Suite. Set your grep
 " program to always generate a file-name.
 set grepprg=grep\ -nH\ $*

 " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
 " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
 " The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'


""""""""""""""""""""
" SESSION
""""""""""""""""""""
let g:local_session_filename='.local-session.vim'
"let g:gsession_non_default_mapping=1   "redefine <leader> mapping behaviour (never set)

