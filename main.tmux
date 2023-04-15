#!/usr/bin/env bash
# Entry point for this TPM plugin.

set -o errexit
set -o pipefail

export TMUX_POWERLINE_DIR_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Obtain the left/right status length settings by reading the tmux-powerline config.
source "${TMUX_POWERLINE_DIR_HOME}/lib/headers.sh"
process_settings

# Configure tmux to use tmux-powerline.
# It's assumed that this will override these setting if already set in tmux.conf, as TPM is recommended to be loaded last in the tmux.conf. Ref: https://github.com/tmux-plugins/tpm
tmux set-option -g status on
tmux set-option -g status-interval 2
tmux set-option -g status-justify "centre"
tmux set-option -g status-left-length $TMUX_POWERLINE_STATUS_LEFT_LENGTH
tmux set-option -g status-right-length $TMUX_POWERLINE_STATUS_RIGHT_LENGTH
tmux set-option -g status-left "#(${TMUX_POWERLINE_DIR_HOME}/powerline.sh left)"
tmux set-option -g status-right "#(${TMUX_POWERLINE_DIR_HOME}/powerline.sh right)"
tmux set-hook -g session-created "run-shell '${TMUX_POWERLINE_DIR_HOME}/powerline.sh init'"
