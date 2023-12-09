#!/bin/bash

############## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU'RE DOING! ##############

# Determine the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || exit 1

# Set some colors for output messages
OK="$(tput setaf 2)[OK]$(tput sgr0)"
ERROR="$(tput setaf 1)[ERROR]$(tput sgr0)"
NOTE="$(tput setaf 3)[NOTE]$(tput sgr0)"
WARN="$(tput setaf 166)[WARN]$(tput sgr0)"
CAT="$(tput setaf 6)[ACTION]$(tput sgr0)"
ORANGE=$(tput setaf 166)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# Set the name of the log file to include the current date and time
LOG="install-$(date +'%d-%H%M%S')_swww.log"

printf "${NOTE} Installing swww\n"

# Check if swww folder exists and remove it
if [ -d "swww" ]; then
  printf "${NOTE} Removing existing swww folder...\n"
  rm -rf "swww" 2>&1 | tee -a "$LOG"
fi

if git clone https://github.com/Horus645/swww.git 2>&1 | tee -a "$LOG"; then
  cd swww || exit 1
  source "$HOME/.cargo/env"
  cargo build --release 2>&1 | tee -a "$LOG"
  # Copy binaries to /usr/bin/
  sudo cp target/release/swww /usr/bin/ 2>&1 | tee -a "$LOG"
  sudo cp target/release/swww-daemon /usr/bin/ 2>&1 | tee -a "$LOG"

  # Copy bash completions
  sudo mkdir -p /usr/share/bash-completion/completions 2>&1 | tee -a "$LOG"
  sudo cp completions/swww.bash /usr/share/bash-completion/completions/swww 2>&1 | tee -a "$LOG"

  # Copy zsh completions
  sudo mkdir -p /usr/share/zsh/site-functions 2>&1 | tee -a "$LOG"
  sudo cp completions/_swww /usr/share/zsh/site-functions/_swww 2>&1 | tee -a "$LOG"

  # Return to the previous directory
  cd - || exit 1
else
  echo -e "${ERROR} Download failed for swww" 2>&1 | tee -a "$LOG"
fi

