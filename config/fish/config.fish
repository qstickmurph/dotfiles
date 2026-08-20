set -g fish_greeting

fish_add_path --path $PATH $HOME/.dotnet/tools

if status is-interactive
  eval (ssh-agent -c) > /dev/null
  ssh-add ~/.ssh/quinn-debian-wsl > /dev/null

  # Load aliases
  if test -f ~/.config/fish/aliases.fish
    source ~/.config/fish/aliases.fish
  end
end
