# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zdotdir/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias config='git --git-dir=$HOME/.config/dotfiles --work-tree=$HOME'

### Added by Zinit's installer --------------------------------------------------------------------
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# examples here -> https://wiki.zshell.dev/ecosystem/category/-annexes
zicompinit # <- https://wiki.zshell.dev/docs/guides/commands
zi light-mode for \
  z-shell/z-a-meta-plugins \
  @annexes # <- https://wiki.zshell.dev/ecosystem/category/-annexes
# examples here -> https://wiki.zshell.dev/community/gallery/collection
zicompinit # <- https://wiki.zshell.dev/docs/guides/commands


#
# Programs
#

# fzf
zinit ice from"gh-r" as"command"
zinit load junegunn/fzf-bin

# ripgrep
zinit ice as"program" from"gh-r" mv"ripgrep* -> rg" pick"rg/rg"
zinit light BurntSushi/ripgrep

# exa
zinit ice as"program" from"gh-r" mv"bin/exa* -> exa" pick"exa/exa"
zinit light ogham/exa

# bat
zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

# fd
zinit ice as"program" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd


# xz
# zinit ice as"command" from"gh-r" mv"xz* -> xz" pick"xz/xz"
# zinit light xz-mirror/xz

# helix
# zinit ice as"command" from"gh-r" mv"*-x86_64-linux/hx -> hx" bpick"*-x86_64-linux.tar.xz" pick"hx"
# zinit light helix-editor/helix

#
# Aloxaf-fzf-tab
# https://wiki.zshell.dev/community/gallery/collection/completions#comp-aloxaf-fzf-tab
#
# NOTE: fzf-tab needs to be loaded after compinit, but before plugins which will wrap widgets,
# such as zsh-autosuggestions or fast-syntax-highlighting!!
zinit light Aloxaf/fzf-tab

#
# https://wiki.zshell.dev/community/gallery/collection/completions#comp-docker-cli
#
zi ice as"completion"
zi snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker


### https://zdharma.org/zinit/wiki/Example-Minimal-Setup/ -----------------------------------------
#
# - syntax-highlighting
# - autosuggestions
# - completions
#
zinit wait lucid light-mode for \
 atinit"zicompinit; zicdreplay" \
     zdharma/fast-syntax-highlighting \
 atload"_zsh_autosuggest_start" \
     zsh-users/zsh-autosuggestions \
 blockf atpull'zinit creinstall -q .' \
     zsh-users/zsh-completions



#
# https://z.digitalclouds.dev/docs/gallery/collection/themes#thp-romkatvpowerlevel10k
#
zi ice depth=1; zi light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.config/zdotdir/.p10k.zsh.
[[ ! -f ~/.config/zdotdir/.p10k.zsh ]] || source ~/.config/zdotdir/.p10k.zsh




### History configuration -------------------------------------------------------------------------
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$ZDOTDIR/.zsh_history


### Configurações diversas através do "setopt" ----------------------------------------------------
#
# Lista de todas as opções disponíveis: http://zsh.sourceforge.net/Doc/Release/Options.html
#
# (inspirado em https://matt.blissett.me.uk/linux/zsh/zshrc)

# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt RM_STAR_WAIT

# Background processes aren't killed on exit of shell
setopt AUTO_CONTINUE

# Don’t write over existing files with >, use >! instead
setopt NOCLOBBER



### bindkeys  -------------------------------------------------------------------------------------
bindkey -v                        # Use vi keybindings
bindkey "^[[1;5C" forward-word    # ctrl right
bindkey "^[[1;5D" backward-word   # ctrl left

bindkey '^R' history-incremental-search-backward	# necessary when using "bindkey -v"




### aliases ---------------------------------------------------------------------------------------
[ -f $ZDOTDIR/.zsh_aliases ] && source "$ZDOTDIR/.zsh_aliases"
[ -f $ZDOTDIR/.zsh_extra_aliases ] && source "$ZDOTDIR/.zsh_extra_aliases"
