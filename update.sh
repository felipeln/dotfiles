# update tmux config
echo "updating 🔃 tmux config"

rsync -avh --delete ~/.tmux ~/dotfiles/tmux/

rsync -avh --delete ~/.tmux.conf ~/dotfiles/tmux/

# update alacritty config

echo "updating 🔃 alacritty config"

rsync -avh --delete /mnt/c/users/felipe/appdata/roaming/alacritty/ ~/dotfiles/alacritty/

# update helix config

echo "updating 🔃 helix config"

rsync -avh --delete ~/.config/helix/ ~/dotfiles/helix/

# update zsh config

echo "updating 🔃 zsh config"

rsync -avh --delete ~/.zshrc ~/dotfiles/zsh/

echo "setup updated ✅"

#update zellij config
echo "updating 🔃 Zellij config"

rsync -avh --delete ~/.config/zellij/ ~/dotfiles/zellij

#update vscode
echo "updating 🔃 VSCode config"

rsync -avh --delete "/mnt/c/users/felipe/AppData/Roaming/Code - Insiders/User/mcp.json" ~/dotfiles/vscode/

rsync -avh --delete "/mnt/c/users/felipe/AppData/Roaming/Code - Insiders/User/settings.json" ~/dotfiles/vscode/

code-insiders --list-extensions >~/dotfiles/vscode/extensions.txt
