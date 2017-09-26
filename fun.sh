echo "========================================================================="
echo "Installing devilspie"
echo "========================================================================="
echo ""
yes | sudo apt-get install devilspie
echo "========================================================================="
echo "Linking dotfile "
echo "========================================================================="
if [ ! -d ~/.devilspie ] ; then
    mkdir ~/.devilspie
fi
ln -fv DesktopConsole.ds ~/.devilspie/DesktopConsole.ds
