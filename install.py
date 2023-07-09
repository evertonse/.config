#!/usr/bin/python3
import sys
import os
from pathlib import Path
import vscode.install as vs
from shutil import copytree, rmtree as rmdir, copy as cp
from glob import glob
from functools import partial

cpdir = partial(copytree, dirs_exist_ok=True)
home = Path.home()
installs = {1: "vscode", 2: "dotfiles", 3: "kitty", 4:'dotdirs'}

def dotdirs():
    dirs = [
        './.sh/',
        './.zsh/',
        './alacritty/',
        './autosetup/'
    ]

    for dir in dirs:
        dir = Path(dir)
        if (
            autoyes
            or input(
                f"About to copy and overwrite src={dir} into dest={Path(home,dir)} [y/n]?"
            ).lower()
            == "y"
        ):
            cpdir(dir, Path(home, dir))
    
def dotfiles():
    files = ["./.bashrc",
        "./.tmux.conf",
        "./.gdbinit",
        "./.zshrc",
        "./.p10k.zsh",
        "./dolphinrc",

    ]


    for f in files:
        f = Path(f)
        if (
            autoyes
            or input(
                f"About to copy and overwrite src={f} into dest={Path(home,f)} [y/n]?"
            ).lower()
            == "y"
        ):
            cp(f, Path(home, f))


autoyes = False


def main():
    global autoyes
    argc = len(sys.argv)
    if argc > 1 and sys.argv[1].lower() == "-y":
        print("Chose -y, will not prompt and will override config ")
        autoyes = True

    if os.name == "nt":
        print("Windows not supported for automatically install")
        exit(69)

    print("Which one do you wish to install ? ")
    for key, value in installs.items():
        print(f"{key} : {value}")

    which = installs[int(input())]
    if which == "vscode":
        vs.install()

    elif which == "dotdirs":
        dotdirs()
    elif which == "dotfiles":
        dotfiles()
    elif which == "kitty":
        dest = Path(home, ".config", "kitty")
        if (
            autoyes
            or input(f"about to  copy src=./kitty in to dest={dest}[y/n]").lower()
            == "y"
        ):
            cpdir("./kitty", dest)



if __name__ == "__main__":
    main()

