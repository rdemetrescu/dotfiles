# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zdotdir/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# zinit setup
# https://github.com/zdharma-continuum/zinit?tab=readme-ov-file#manual
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"



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
zinit ice as"command" from"gh-r" mv"xz* -> xz" pick"xz/xz"
zinit light tukaani-project/xz

# helix
zinit ice as"command" from"gh-r" mv"*-x86_64-linux/hx -> hx" bpick"*-x86_64-linux.tar.xz" pick"hx"
zinit light helix-editor/helix




#
# zsh plugins
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
# powerlevel10k
#
zinit ice depth"1"; zinit light romkatv/powerlevel10k


### History configuration -------------------------------------------------------------------------

HISTSIZE=1000
SAVEHIST=$HISTSIZE
HISTFILE=$ZDOTDIR/.zsh_history
HISTDUP=erase

setopt append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


### Configurações diversas através do "setopt" ----------------------------------------------------
#
# Lista de todas as opções disponíveis: http://zsh.sourceforge.net/Doc/Release/Options.html
#
# (inspirado em https://matt.blissett.me.uk/linux/zsh/zshrc)

# Prompts for confirmation after 'rm *' etc
# Helps avoid mistakes like 'rm * o' when 'rm *.o' was intended
setopt rm_star_wait

# Background processes aren't killed on exit of shell
setopt auto_continue

# Don’t write over existing files with >, use >! instead
setopt noclobber



# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


### bindkeys  -------------------------------------------------------------------------------------
bindkey -v                        # Use vi keybindings
bindkey "^[[1;5C" forward-word    # ctrl right
bindkey "^[[1;5D" backward-word   # ctrl left

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

zinit light zdharma-continuum/history-search-multi-word


### aliases ---------------------------------------------------------------------------------------
[ -f $ZDOTDIR/.zsh_aliases ] && source "$ZDOTDIR/.zsh_aliases"
[ -f $ZDOTDIR/.zsh_extra_aliases ] && source "$ZDOTDIR/.zsh_extra_aliases"


# To customize prompt, run `p10k configure` or edit ~/.config/zdotdir/.p10k.zsh.
[[ ! -f ~/.config/zdotdir/.p10k.zsh ]] || source ~/.config/zdotdir/.p10k.zsh
