export PATH=$PATH:/home/sawyer/.local/bin:/home/sawyer/go/bin:/home/sawyer/.dotnet/tools:/home/sawyer/bin:/usr/local/go/bin:/usr/local/zig:/opt/mssql-tools18/bin
source ~/.upekkha_prompt

export EDITOR=nvim

HISTFILE=~/.zsh_history

HISTSIZE=10000
SAVEHIST=10000

setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS

autoload -Uz compinit
compinit
autoload -U up-line-or-beginning-search down-line-or-beginning-search

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

bindkey -v

alias l='ls -lah'
alias bigdata='cd /mnt/bigdata/'
alias vi='nvim'
alias gleaners='cd /mnt/bigdata/Backup/Sync/sawyers-surface-backup/repos/gleaners'
alias repos='cd /mnt/bigdata/Backup/Sync/repos'
alias tm='tmuxinator'
alias open='xdg-open'

# TaskWarrior

alias t='task -in -maybe -BLOCKED'
alias tt='task all status:pending or status:waiting'
alias in="task add +in"
alias maybe="task add +maybe"
alias tc="task +maybe"
alias ti='task +in +PENDING'

tickle () {
	deadline = $1
	shift
	in +tickle wait:$deadline $@
}
alias tick=tickle

alias ta='task add +next'
alias tm='task modify'

task_wait () {
	task modify +waiting -next -in $1 wait:$2
	if [[ "${*:3}" != "" ]]; then
		task $1 annotate "${@:3}" 
	fi
}
alias tw=task_wait

alias td='task done'
alias tx='task delete'
alias tn='task modify +next'
alias tnn='task modify -next'
alias ts='task start'
alias tss='task stop'

alias so='source ~/.zshrc'
alias clip='xclip -selection clipboard'
alias img-dl='xclip -selection clibpard > temp; aria2c -i temp -d "Pictures/$(date "+%H-%M-%S--%d--%Y")" ; rm temp'

export BW_SESSION="$(cat /home/sawyer/bw-session)"

alias start_conda="/home/sawyer/miniconda3/etc/profile.d/conda.sh"

export CONDA_AUTO_ACTIVATE_BASE=false

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sawyer/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sawyer/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/sawyer/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sawyer/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

