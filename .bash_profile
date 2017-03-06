#!/bin/bash

# Ensures global access to Yarn binaries
export PATH="$PATH:`yarn global bin`"

# Switch to the projects directory
cd ~/Projects

# Only run these scripts if TMUX hasn't been loaded yet
# @link   http://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if [ -z ${TMUX+x} ] 
then

	# Make the Terminal window go full screen
	# @link   http://superuser.com/questions/870732/os-x-command-to-make-current-terminal-window-full-screen
	osascript -e 'tell app "Terminal" to activate'
	osascript -e 'tell app "System Events" to keystroke "f" using { command down, control down }'

	# Configure TMUX
	# @link   https://blog.htbaa.com/news/tmux-scripting
	
	# Create session
	SESSION=$USER
	tmux new-session -d -s $SESSION
	
	# Change the color of the active pane
	# @link   http://stackoverflow.com/questions/25532773/change-background-color-of-active-or-inactive-pane-in-tmux
	tmux set -g window-style 'fg=colour247,bg=colour240'
	tmux set -g window-active-style 'fg=colour250,bg=black'

	# Get the number of TMUX panes
	PANE_COUNT=$(tmux list-panes | wc -l)

	# If the number of panes is still one, split it up automatically
	if (($PANE_COUNT <= 1))
	then
		tmux split-window -h -t $SESSION:0
	fi

	# Make sure the first pane is active
	tmux select-pane -t 0

	# Launch TMUX
	tmux attach-session -t $SESSION

fi
