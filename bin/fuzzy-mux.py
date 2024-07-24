#!/bin/python3
import subprocess
import os
import sys
import time

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

def get_tmuxinator_files():
    tmuxinator_files = os.listdir('/home/sawyer/.config/tmuxinator/')
    for i, f in enumerate(tmuxinator_files):
        tmuxinator_files[i] = f[:-4]

    return tmuxinator_files;

def select_session():
    tmuxinator_files = get_tmuxinator_files()

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
        time.sleep(1)
        subprocess.run(['tmux', 'switch-client', '-t', selection])

def open_session(session, tmuxinator_files):
    if (session in sessions):
        subprocess.run(['tmux', 'switch-client', '-t', session])

    if (session in tmuxinator_files):
        subprocess.run(['tmuxinator', session])

if (sys.argv[1] == 'open' or sys.argv[1] == 'o'):
    select_session()
elif (sys.argv[1] == 'c' or sys.argv[1] == 'close'):
    close_session()
else:
    tmuxinator_files = get_tmuxinator_files()
    open_session(sys.argv[1], tmuxinator_files)
