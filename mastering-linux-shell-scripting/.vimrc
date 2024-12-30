# The options we set are detailed in the following list:
# 
# set showmode: Ensures we see when we are in insert mode
# set nohlsearch: Does not highlight the words that we have searched for
# set autoindent: We indent our code often; this allows us to return to the last indent level rather than the start of a new line on each line break
# set tabstop=4: Sets a tab to be four spaces
# set expandtab: Converts tabs to spaces, which is useful when the file moves to other systems
# syntax on: Note that this does not use the set command and is used to turn on syntax highlighting
# When these options are set, the $HOME/.vimrc file should look similar to this:

set showmode 
set nohlsearch 
set autoindent 
set tabstop=4 
set expandtab 
syntax on 