# This repo contains the basic configuration for UNIX based sysetms that i presonally like

TMUX Configuration
Put .tmux.conf file in your home directory and reboot ur tmux process of just go '''cd ~ '''

## Apply the new configuration:

After saving changes to .tmux.conf, you can either:
Restart tmux (close all sessions and start a new one).
Or reload the configuration in an active tmux session using this command:

'''
tmux source-file ~/.tmux.conf
'''

and check the configuration

'''
tmux show-options -g
'''
