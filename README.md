# Dotfiles


## Setup for new machine

**dotfiles**

```shell
git clone --bare https://github.com/rdemetrescu/dotfiles.git $HOME/.config/dotfiles
alias config='git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config reset --hard HEAD
```

## Resources

* [Git Bare Repository - A Better Way To Manage Dotfiles](https://www.youtube.com/watch?v=tBoLDpTWVOM)
* [https://wiki.zshell.dev/docs](https://wiki.zshell.dev/docs)
