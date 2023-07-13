#!/usr/bin/python3
import sys
import os
from pathlib import Path
from shutil import copytree, rmtree as rmdir, copy as cp, move as mv 
from glob import glob
from functools import partial

cpdir = partial(copytree, dirs_exist_ok=True)
home = Path.home()
installs = ["dotfiles", 'dotdirs', 'dotrepos']

def dotdirs():
    dirs = [
        *glob('.config/*/'),
        './autosetup/',
        './.local/bin'
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

    
def dotrepos():
    home = Path.home()
    os.system(f"rm -rf {Path(home,'.config','nvim').resolve()}")
    os.system(f"rm -rf {Path(home,'.local','share','nvim').resolve()}")

    os.system(f"git clone https://github.com/NvChad/NvChad {Path(home,'.config','nvim')} --depth 1")
    os.system(f"git clone https://github.com/evertonse/nvchad-custom {Path(home,'.config','nvim', 'lua','custom')}")

def neovim():
    neovim_path = Path(home,'code','neovim')
    os.system(f"git clone  https://github.com/neovim/neovim {neovim_path}")
    os.system(f"cd {neovim_path}")
    os.system(f"make CMAKE_BUILD_TYPE=RelWithDebInfo")
    os.system("sudo make install")

    
def dotfiles():
    files = [
        "./.bashrc",
        "./.gdbinit",
        "./.zshrc",
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
    for key, value in enumerate(installs):
        print(f"{key+1} : {value}")
    which = installs[int(input())-1]

    if which == "dotdirs":
        dotdirs()
    elif which == "dotfiles":
        dotfiles()
    elif which == "dotrepos":
        dotrepos()


if __name__ == "__main__":
    main()

