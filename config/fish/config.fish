set -g fish_greeting

if status is-interactive
  # Load aliases
  if test -f ~/.config/fish/aliases.fish
    source ~/.config/fish/aliases.fish
  end
end
