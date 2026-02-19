#!/data/data/com.termux/files/usr/bin/bash
CYAN="\e[38;5;51m"; RED="\e[38;5;196m"; WHITE="\e[38;5;231m"; RESET="\e[0m"
clear
echo -e "${CYAN}┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
echo -e "┃  ${WHITE}INSTALLING ALX-NODE-MYTHEME v2.0${CYAN}          ┃"
echo -e "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${RESET}"

pkg update && pkg upgrade -y
pkg install zsh git eza ncurses-utils curl -y

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom/plugins"
[ ! -d "${ZSH_CUSTOM}/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/zsh-autosuggestions
[ ! -d "${ZSH_CUSTOM}/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM}/zsh-syntax-highlighting

cat << 'EOF' > ~/.login.sh
#!/data/data/com.termux/files/usr/bin/bash
trap '' SIGINT SIGTSTP 2>/dev/null
PASS_FILE="$HOME/.vault_key"
RED="\e[38;5;196m"; PURPLE="\e[38;5;93m"; GRAY="\e[38;5;238m"; WHITE="\e[38;5;231m"; RESET="\e[0m"
if [ ! -f "$PASS_FILE" ]; then
    printf "${PURPLE}SET NEW ACCESS KEY: ${RESET}"
    stty -echo; read p1; stty echo; echo "$p1" > "$PASS_FILE"; clear
fi
SENHA_MESTRA=$(cat "$PASS_FILE")
clear
printf "\n${PURPLE} ▟ ${WHITE}ALXNRX DARK-NODE ${RED}⟁ ${PURPLE}SECURITY\n"
printf "${PURPLE} ⣇ ${WHITE}ENTER KEY: ${RESET}"
stty -echo
if read -t 15 input_senha; then
    stty echo
    [ "$input_senha" = "$SENHA_MESTRA" ] && clear || kill -9 $PPID
else
    stty echo; kill -9 $PPID
fi
EOF
chmod +x ~/.login.sh

cat << 'EOF' > ~/.zshrc
[ -f ~/.login.sh ] && bash ~/.login.sh
export ZSH=$HOME/.oh-my-zsh
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
alias ls='eza --icons --group-directories-first --grid --color=always'
alias ll='eza --icons -l'
C1="%F{51}"; C2="%F{196}"; C3="%F{231}"; C4="%F{242}"
export PROMPT=$'\n${C4}▗\e[1;30m───────────────────────────────────\n${C1} ⣇ ${C3}ALXNRX ${C2}⟁ ${C1}NODE:${C3}%~ \n${C4} ▝──────%F{196}╼ ${C3}† %f'
export TERM=xterm-256color
EOF

echo -e "\n${RED}[+] DEPLOY FINALIZADO.${WHITE} REINICIE O TERMUX!${RESET}"

