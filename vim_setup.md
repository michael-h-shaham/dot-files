# Vim setup

First, install Node.js following the instructions 
[here](https://github.com/nodesource/distributions/blob/master/README.md).

Install a minimalist Vim plugin manager by following the instructions
[here](https://github.com/junegunn/vim-plug).

Install ccls (on Ubuntu) using 
```bash
sudo apt install ccls
```

My `.bashrc` already has a few plugins it uses --- one for code completion 
([coc](https://github.com/neoclide/coc.nvim))
and one for code commenting 
([vim-commentary](https://github.com/tpope/vim-commentary)), and a lot of 
the code in the `.bashrc` is copy-and-pasted from the coc example.

In `vim`, type `:PlugInstall` to install the plugins.

You can install various 
[coc extensions](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions)
by typing `:CocInstall <extension_name>` while in Vim. For example, for C++ 
code completion, run 
```bash
:CocInstall coc-clangd
```

When you actually edit a C++ file for the first time, you will also have to run:
```bash
:CocCommand clangd.install
```
