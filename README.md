# dotfiles
 my dotfiles of Arch Linux

## Dependency
- [git](https://github.com/git/git)
- [GNU stow](https://www.gnu.org/software/stow/)

## Installing
cd into your `$HOME` directory or simply `~` and then
```bash
git clone https://github.com/dingZvel/dotfiles.git
```
## Usage
using GNU stow in `dotfiles` directory to symlink the config e.g.
```bash
stow zsh   # this will only apply zsh config
```
or
```bash
stow */    # symlink everything (the '/' ignores the README.md)
```
