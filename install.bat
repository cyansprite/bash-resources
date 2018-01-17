echo OFF

:: resources time
echo "========================================================================="
echo "Linking dotfiles to home "
echo "========================================================================="
DEL "%homepath%\.bashrc"
DEL "%homepath%\.bash_aliases"
DEL "%homepath%\.dircolors"
DEL "%homepath%\.gitconfig"
DEL "%homepath%\.tmux.conf"
DEL "%homepath%\bashrc.cmd"

MKLINK /H "%homepath%\.bashrc" .bashrc
MKLINK /H "%homepath%\.bash_aliases" .bash_aliases
MKLINK /H "%homepath%\.dircolors" .dircolors
MKLINK /H "%homepath%\.gitconfig" .gitconfig
MKLINK /H "%homepath%\.tmux.conf" .tmux.conf
MKLINK /H "%homepath%\bashrc.cmd" bashrc.cmd

echo ""

:: make sure we neovim stuffs
echo "========================================================================="
echo "Linking nvim"
echo "========================================================================="

cd nvim-plugs
DEL "%homepath%\AppData\Local\nvim\init.vim"
DEL "%homepath%\AppData\Local\nvim\plug.vim"
MKLINK /H "%homepath%\AppData\Local\nvim\init.vim" init.vim
MKLINK /H "%homepath%\AppData\Local\nvim\plug.vim" plug.vim
cd ..

echo ""
