# IMP: most important paths do not edit

 export PATH=$HOME/bin:/usr/local/bin:$PATH
 export PATH=$HOME/.zsh:$PATH.zsh
 export PATH=$PATH:/usr/sbin


# NOTICE: setup paths 

 export PATH=$PATH:$GOPATH/bin 
 export PATH=$PATH:$HOME/.local/bin
 export PATH="$HOME/.cargo/bin:$PATH"
 export PATH=$PATH:/usr/bin
 export PATH=$PATH:/usr/local/go/bin
 export PATH=$PATH:~/go/bin


# NOTICE: setup path for linuxbrew

 export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
 export PATH=/usr/local/bin:$PATH


# NOTICE: other paths

 export PATH=$PATH:$HOME/dotfiles/.zsh/scripts
 export PATH=$PATH:/opt/nvim/ 
 export PATH="$BUN_INSTALL/bin:$PATH"
 export OPENSSL_CONF=
 export NVM_DIR="$HOME/.nvm"  
 export ZSH=$HOME/.oh-my-zsh
 export GOPATH=$HOME/go
 export MANPATH=/usr/local/man:$MANPATH
 export FZF_ALT_C_OPTS="--preview 'exa -lah --icons {}'"
 export ARCHFLAGS="-arch x86_64"
 export LANG="en_US.UTF-8"
 export BUN_INSTALL="$HOME/.bun"
 export PNPM_HOME="/home/samarth/.local/share/pnpm"
# export FUNCNEST=100 # IMP: this stops the recurstion limit to 100

. "/home/samarth/.deno/env"
fpath=($HOME/.zsh_completions $fpath)


export VISUAL=nvim
export EDITOR=nvim

 if [[ -n $SSH_CONNECTION ]]; then # INFO: Preferred editor for local and remote sessions
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

# IMP: this binds capslock to ctrl for wayland 
 gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"


 CASE_SENSITIVE="false"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
 HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
 # zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
 # zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the follow`ing line to enable command auto-correction.
 #ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
 COMPLETION_WAITING_DOTS="false"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
 DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=( zsh-autopair history web-search encode64 copypath zsh-syntax-highlighting zsh-autosuggestions docker docker-compose git kubectl kubectx colored-man-pages )

source $ZSH/oh-my-zsh.sh
# web_search from terminal

  function web_search() {
    emulate -L zsh

    # define search engine URLS
    typeset -A urls
    urls=(
      $ZSH_WEB_SEARCH_ENGINES
      google          "https://www.google.com/search?q="
      bing            "https://www.bing.com/search?q="
      brave           "https://search.brave.com/search?q="
      yahoo           "https://search.yahoo.com/search?p="
      dckduckgo      "https://www.duckduckgo.com/?q="
      startpage       "https://www.startpage.com/do/search?q="
      yandex          "https://yandex.ru/yandsearch?text="
      github          "https://github.com/search?q="
      baidu           "https://www.baidu.com/s?wd="
      ecosia          "https://www.ecosia.org/search?q="
      goodreads       "https://www.goodreads.com/search?q="
      qwant           "https://www.qwant.com/?q="
      givero          "https://www.givero.com/search?q="
      stackoverflow   "https://stackoverflow.com/search?q="
      wolframalpha    "https://www.wolframalpha.com/input/?i="
      archive         "https://web.archive.org/web/*/"
      scholar         "https://scholar.google.com/scholar?q="
      ask             "https://www.ask.com/web?q="
      youtube         "https://www.youtube.com/results?search_query="
      phind           "https://www.phind.com/search?q="
      mdn             "https://developer.mozilla.org/en-US/search?q="
      gpt             "https://chat.openai.com/"
      px              "https://www.perplexity.ai/search?q="
    )

    # check whether the search engine is supported
    if [[ -z "$urls[$1]" ]]; then
      echo "Search engine '$1' not supported."
      return 1
    fi

    # search or go to main page depending on number of arguments passed
    if [[ $# -gt 1 ]]; then
      # build search url:
      # join arguments passed with '+', then append to search engine URL
      url="${urls[$1]}$(omz_urlencode ${@[2,-1]})"
    else
      # build main page url:
      # split by '/', then rejoin protocol (1) and domain (2) parts with '//'
      url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
    fi

    open_command "$url"
  }




#IMP: sourcing other files 
source ~/.zsh/others/alias.sh
source ~/.zsh/others/commands.sh
source ~/.zsh/others/completions.sh #NOTE: completions for third party tools
source ~/pins.sh #TODO: setup your private keys here
source /usr/share/fzf/shell/key-bindings.zsh



#X!: The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/samna/google-cloud-sdk/path.zsh.inc' ]; then . '/home/samna/google-cloud-sdk/path.zsh.inc'; fi

#X!: The next line enables shell command completion for gcloud.
if [ -f '/home/samna/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/samna/google-cloud-sdk/completion.zsh.inc'; fi



 

 eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 
 eval "$(starship init zsh)" # from prompt
 eval "$(zoxide init zsh)"   # for better cd
 eval "$(atuin init zsh)"    # for better history

alias cd='z' #WARN: DISABLE THIS IF YOURE NOT USING ZOXIDE 
export ATUIN_NOBIND="true"
bindkey '^k' atuin-search

# zsh fzf setup
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pnpm
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/home/samarth/.bun/_bun" ] && source "/home/samarth/.bun/_bun"
