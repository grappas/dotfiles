# ~/.bashrc

# Nie rób nic jeśli nie interaktywny
[[ $- != *i* ]] && return

# ── ble.sh ────────────────────────────────────────────────────────────────────
[[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach

# ── Historia ──────────────────────────────────────────────────────────────────
HISTCONTROL=ignoredups:erasedups
HISTSIZE=10000
HISTFILESIZE=100000
shopt -s histappend

# Strzałki = szukaj w historii po prefiksie
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# ── grc ───────────────────────────────────────────────────────────────────────
GRC_ALIASES=true
[[ -s "/etc/profile.d/grc.sh" ]] && source /etc/profile.d/grc.sh || echo "grc not found, skipping"
alias grep='grep --colour=auto'
alias ls='grc ls'

# ── jlog ──────────────────────────────────────────────────────────────────────
jlog() {
  journalctl -xeu "$@" --follow
}
_jlog_complete() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=($(compgen -W "$(systemctl list-units --type=service --no-legend --no-pager | awk '{print $1}')" -- "$cur"))
}
complete -F _jlog_complete jlog

# ── fzf ───────────────────────────────────────────────────────────────────────
eval "$(fzf --bash)"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always {}' --preview-window=right:50%"

# ── done (powiadomienie po długich komendach) ─────────────────────────────────
__done_threshold=10
__done_timer_start() { __done_start=$SECONDS; }
__done_timer_stop() {
  local elapsed=$((SECONDS - ${__done_start:-$SECONDS}))
  if ((elapsed >= __done_threshold)); then
    local last_cmd
    last_cmd=$(history 1 | sed 's/^ *[0-9]* *//')
    notify-send "✅ Gotowe" "\"$last_cmd\" zajęło ${elapsed}s" 2>/dev/null || echo -e "\a"
  fi
}
trap '__done_timer_start' DEBUG
PROMPT_COMMAND+='__done_timer_stop'

# ── starship (musi być ostatni) ───────────────────────────────────────────────
eval "$(starship init bash)"

[[ ${BLE_VERSION-} ]] && ble-attach
