# Confetti syntax for Vim and Neovim

A small, application-independent Vim syntax plugin for
[Confetti](https://confetti.hgs3.me/) files.

It recognizes `.confetti` files, highlights their syntax, and sets `#` as the
buffer’s comment leader. The plugin does not assume that a particular program
interprets Confetti directives: it is equally suitable for configuration files,
scripts, and languages built on Confetti.

## Highlighting

- Directive names (the first bare word of a directive, including dashed names)
- Comments beginning with `#`
- Double-quoted and triple-quoted strings, including escapes
- Braces and semicolons
- Operator-looking arguments such as `+`, `==`, `&&`, and `||`
- Numeric-looking arguments such as `42`, `7.5`, `.125`, `1_000`, and `3s`

Confetti deliberately leaves the meaning of directive names and their arguments
to the application. Accordingly, these are *syntax highlighting* rules, not a
validator. Colors depend on the active Vim colorscheme.

## Installation

### Vim 8+ native packages

Clone the published repository into a directory beneath Vim’s `pack/*/start/`:

```sh
mkdir -p ~/.vim/pack/plugins/start
git clone https://github.com/unclechu/confetti-vim-syntax ~/.vim/pack/plugins/start/confetti-vim
```

### Neovim native packages

```sh
mkdir -p ~/.local/share/nvim/site/pack/plugins/start
git clone https://github.com/unclechu/confetti-vim-syntax ~/.local/share/nvim/site/pack/plugins/start/confetti-vim
```

### Manual installation

From a checkout of this repository, copy its three runtime files into your
Vim runtime directory:

```sh
mkdir -p ~/.vim/ftdetect ~/.vim/ftplugin ~/.vim/syntax
cp ftdetect/confetti.vim ~/.vim/ftdetect/
cp ftplugin/confetti.vim ~/.vim/ftplugin/
cp syntax/confetti.vim ~/.vim/syntax/
```

For Neovim, replace `~/.vim` with `~/.config/nvim`.

### Project-local checkout

You can also keep the plugin in a project directory without installing it
globally. Add its **absolute path** to Vim’s `runtimepath` from your Vim
configuration, before enabling filetype detection and syntax:

```vim
set runtimepath^=/absolute/path/to/confetti-vim-syntax
filetype plugin on
syntax enable
```

The relative path `./` depends on Vim’s current working directory, so an
absolute path is more reliable. If you use a project-local `.vimrc`, load it
only for projects you trust: Vim does not read such files automatically unless
you opt in to that behavior.

## Usage

Enable filetype plugins and syntax highlighting in `~/.vimrc` or
`~/.config/nvim/init.vim` if they are not already enabled:

```vim
filetype plugin on
syntax enable
```

Open any `*.confetti` file:

```sh
vim example.confetti
```

For example:

```confetti
# Ordinary Confetti directives and nested blocks
project "demo" {
  version 1.2.3
  start-delay 3s
  sources {init.c fork.c scheduler.c}
  message """Hello,
from Confetti!"""
}
```

To check detection, run `:set filetype?` inside Vim; it should report
`filetype=confetti`. If necessary, use `:setfiletype confetti` to enable it
manually for the current buffer.

## Files

| Path                    | Purpose                               |
| ---                     | ---                                   |
| `ftdetect/confetti.vim` | Detect `*.confetti` files             |
| `syntax/confetti.vim`   | Highlight the generic Confetti syntax |
| `ftplugin/confetti.vim` | Set buffer-local comment formatting   |

## Public domain

This plugin is released into the public domain under
[The Unlicense](https://unlicense.org/). See [UNLICENSE](UNLICENSE) for the full
dedication and warranty disclaimer. You may use, copy, modify, and redistribute
it without attribution. Contributors should only submit material they have the
right to dedicate on the same terms.
