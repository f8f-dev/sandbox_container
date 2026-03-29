#!/bin/bash
cat << 'EOF' >> ~/.zprofile

autoload -Uz compinit
compinit
zstyle ':completion:*:ssh:*' tag-order hosts users
export SSH_AUTH_SOCK=~/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock

alias c='container'
alias c-up='container start'
alias c-ls='container list'
alias c-ls-a='container list --all'
alias c-s-up='container system start'
alias c-s-down='container system stop'

c-e-bash() {
  container exec -it "$1" /bin/bash
}

c-e-sh() {
  container exec -it "$1" /bin/sh
}

_container() {
  local -a subcmds
  subcmds=(create delete rm exec inspect kill list ls logs run start stats stop prune export build image registry volume builder network system)

  _arguments '1:subcommand:compadd -a subcmds' '*::arg:->args'

  case $words[1] in
    start|stop|kill|delete|rm|exec|inspect|logs|stats|export)
      local -a containers
      containers=($(container ls 2>/dev/null | awk 'NR>1{print $1}'))
      compadd -a containers
      ;;
  esac
}

compdef _container container
EOF
echo "Done"
