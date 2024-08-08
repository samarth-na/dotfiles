export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/usr/bin
export ZSH="$HOME/.oh-my-zsh"

export VISUAL=nvim
export EDITOR=nvim

export PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/.local/bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh




#########################################################


chpwd() {
 printf "\033]2;%s\007" "$PWD"
}
chpwd()
export FZF_ALT_C_OPTS="--preview 'exa -lah --icons {}'"



CASE_SENSITIVE="false"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# NOTE: add aliases here
# the syntax is:
# alias <alias name>="<command>"

alias ls='eza --icons'



# NOTE: these are th plugins added tou can loook for more plugins in the omz github 
plugins=(sudo history web-search encode64 copypath zsh-syntax-highlighting zsh-autosuggestions)


source $ZSH/oh-my-zsh.sh
# web_search from terminal

function web_search() {
  emulate -L zsh

  #NOTE: define search engine URLS

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
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# WARNING: Preferred editor for local and remote sessions

 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

# Compilation flags
 export ARCHFLAGS="-arch x86_64"

 alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"




# WARNING: delete this if you donnt use google-cloud-sdk this 

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/home/samna/google-cloud-sdk/path.zsh.inc' ]; then . '/home/samna/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
# if [ -f '/home/samna/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/samna/google-cloud-sdk/completion.zsh.inc'; fi

eval "$(starship init zsh)"
#--------------------------------------------------------------------
# bun
source ~/.zsh/aliases/alias.sh
# bun completions
[ -s "/home/samna/.bun/_bun" ] && source "/home/samna/.bun/_bun"%
