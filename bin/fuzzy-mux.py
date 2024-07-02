#!/bin/python3
import subprocess
import os
import sys

sessions = subprocess.run(
    ['tmux', 'list-sessions', '-F', '#{session_name}'],
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    text=True
)

sessions = sessions.stdout.split('\n')

def close_session():
    selection = subprocess.run(
        ['fzf', '--prompt', 'Close Session: '],
        input='\n'.join(sessions),
        stdout=subprocess.PIPE,
        text=True
    ).stdout[:-1]

    subprocess.run(['tmux', 'switch-client', '-t', 'base'])
    subprocess.run(['tmux', 'kill-session', '-t', selection])

def open_session():
    tmuxinator_files = os.listdir('/home/sawyer/.config/tmuxinator/')
    for i, f in enumerate(tmuxinator_files):
        tmuxinator_files[i] = f[:-4]

    combined = set(tmuxinator_files) | set(sessions)
    combined.discard('')

    selection = subprocess.run(
        ['fzf', '--prompt', 'Open Session: '],
        input='\n'.join(combined),
        stdout=subprocess.PIPE,
        text=True
    ).stdout[:-1]

    if (selection in sessions):
        subprocess.run(['tmux', 'switch-client', '-t', selection])

    if (selection in tmuxinator_files):
        subprocess.run(['tmuxinator', selection])

if (sys.argv[1] == 'open' or sys.argv[1] == 'o'):
    open_session()

elif (sys.argv[1] == 'c' or sys.argv[1] == 'close'):
    close_session()
