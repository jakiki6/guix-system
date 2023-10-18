sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo "autoload -U compinit && compinit\nsource ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh\nalias primetime='watch -t -n 1 \"factor \$(date +%s)\"'\nexport GUIX_LOCPATH=\"$HOME/.guix-profile/lib/locale\"\nexport GUIX_PROFILE=\"/home/laura/.guix-profile\"\n. \"$GUIX_PROFILE/etc/profile\"\nexport EDITOR=vim\nexport LD_LIBRARY_PATH=~/.guix-profile/lib:/run/current-system/profile/lib" >> ~/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
exec zsh
