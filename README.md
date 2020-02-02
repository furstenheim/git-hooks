### Git hooks

This aim of this repo is to gather interesting hooks for git. For now only one:


* **prepare-commit-msg-hook**. This hook is interesting in case that you use a ticket system where ticket ids are of the shape `[A-Z]+-[0-9]+`, and you name all your branches by $TICKET-description. For example, `GLEE-313-my-first-branch`. This hook attaches the code at the beginning of the message. So `My first commit` becomes `[GLEE-313] My first commit`.

    The hook is very convenient because it allows to go straight from git blame to the ticket that describes all the context for the change. Some platforms like bitbucket will even automatically link the codes in the messages to the actual tickets. 

    To setup the hook in a particular repo do the following:
    
    
    git clone git@github.com:furstenheim/git-hooks.git
    ln -s $(pwd)/prepare-commit-msg.sh $PATH_TO_YOUR_REPO/.git/hooks/prepare-commit-msg
