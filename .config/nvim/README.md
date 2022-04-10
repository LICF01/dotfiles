# Nvim 

# Setup LSP severs
### Emmet
```shell
npm install -g @kozer/emmet-language-server
```
[https://github.com/kozer/emmet-language-server](https://github.com/kozer/emmet-language-server) Fork that support jsx and tsx files

### JavaScript
```shell
npm i -g typescript typescript-language-server
```
### Lua - Sumneko
- Create a folder called lsp on $HOME
- On Fedora, install libstdc++
```shell
dnf install libstdc++-static
cd lsp/
```
Follow the installation guide https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

# Setup code Formatters
### JavaScript
Prettier
```Shell
npm i -g install Prettier
```

### Lua
Stylua from https://github.com/JohnnyMorganz/StyLua
```shell
cargo install stylua
```
