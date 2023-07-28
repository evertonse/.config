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
cmd = lambda x: print(x) or os.system(x) 
def dotdirs():

    dirs = [
        *glob('.config/*/'),
        './.local/bin',
        './.local/include',
        './.local/share',
    ]
    
    for dir in dirs:
        dir = Path(dir)
        assert dir.is_dir()
        if (
            autoyes
            or input(
                f"About to copy and overwrite src={dir} into dest={Path(home,dir)} [y/n]?"
            ).lower()
            == "y"
        ):
            cpdir(dir, Path(home, dir))
    
    cmd('sudo cp -rf ~/.config/X11/xorg.conf.d/ /etc/X11/')
    # cmd('sudo ln -i -s ~/.local/include/* /usr/include')
    cmd('sudo ln -s ~/.local/include/* /usr/include')
    cmd("chmod +x ./.local/bin/*") 
    cmd("chmod +x ~/.local/bin/*") 
    cmd("ln -s ~/.config/picom/picom.jonaburg.conf ~/.config/picom/picom.conf") 

    
def dotrepos():
    home = Path.home()
    cmd(f"rm -rf {Path(home,'.config','nvim').resolve()}")
    cmd(f"rm -rf {Path(home,'.local','share','nvim').resolve()}")

    cmd(f"git clone https://github.com/NvChad/NvChad {Path(home,'.config','nvim')} --depth 1")
    cmd(f"git clone https://github.com/evertonse/nvchad-custom {Path(home,'.config','nvim', 'lua','custom')}")
    rocks = Path(home,'code','rocks')
    cmd(f"git clone https://github.com/evertonse/rocks {rocks} && cd {rocks} && ./install.sh")

# def neovim():
#     neovim_path = Path(home,'code','neovim')
#     neovim_path.mkdir(parents=True, exist_ok=True)
#     if neovim_path.is_dir():
#         rmdir(neovim_path)
#     cmd(f"git clone  https://github.com/neovim/neovim {neovim_path}")
#     cmd(f"cd {neovim_path}")
#     cmd(f"make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install")

    
def dotfiles():
    files = [
        *glob('./.*'),
        "./pacman.conf",
        "./grub",
        './.gitconfig',
    ]


    for f in files:
        if f == "./pacman.conf":
            cmd(f"sudo cp {Path(f)} {Path('/etc', 'pacman.conf')}")
            continue
        if f == "./grub":
            cmd(f"sudo cp {Path(f)} {Path('/etc', 'default', 'grub')}")
            print(" to ensure the grub config is set use 'sudo grub-mkconfig -o /boot/grub/grub.cfg'")
            continue

        f = Path(f)
        if f.is_dir():
            continue

        if (
            autoyes
            or input(
                # f'for sure this is not a dir isit : {f.is_dir()}'
                # + 
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

