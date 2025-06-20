# update tmux config
echo "updating 🔃  tmux config"
cp -rf ~/.tmux/ ~/dotfiles/tmux
cp -rf ~/.tmux.conf ~/dotfiles/tmux
# update alacritty config
echo "updating 🔃  alacritty config"
cp -rf /mnt/c/users/felipe/appdata/roaming/alacritty ~/dotfiles/alacritty
# update helix config
echo "updating 🔃  helix config"
cp -rf ~/.config/helix ~/dotfiles/
# update zsh config
echo "updating 🔃  zsh config"
cp -rf ~/.zshrc ~/dotfiles/zsh/

echo "setup updated ✅"
