export PATH=$PATH:/home/sawyer/.local/bin:/home/sawyer/go/bin:/home/sawyer/.dotnet/tools:/home/sawyer/bin:/usr/local/go/bin:/usr/local/zig:/opt/mssql-tools18/bin

export EDITOR=nvim

PS1=$'%F{11}%n@%m%f 🐢 %F{14}%(4~|.../%3~|%~)%f \n\e[33m \e[m '

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
