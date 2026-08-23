function fish_prompt
  # Use standard ANSI color variables that pull directly from your terminal theme
  set -l user_color (set_color --bold cyan)
  set -l host_color (set_color --bold yellow)
  set -l path_color (set_color --bold blue)
  set -l git_color  (set_color --bold magenta)
  set -l char_color (set_color --bold green)
  set -l tree_color (set_color brblack)
  set -l normal     (set_color normal)

  # Git branch info
  set -l git_branch ""
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set -l branch (git branch --show-current 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
    if test -n "$branch"
      set git_branch " $git_color($branch)$normal"
    end
  end

  # Line 1: user @ host path (branch)
  echo -s $user_color $USER $normal "@" $host_color (hostnamectl hostname) " " $path_color (prompt_pwd) $git_branch

  # Line 2: └─ $ >
  echo -s $tree_color "└─ " $char_color "\$ > " $normal
end
