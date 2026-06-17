# Nova editor syntax highlighting

These files are **generated** from the real lexer's keyword set, run
`lua5.4 tools/genhl.lua` from the repo root to regenerate. Don't hand-edit.

| file | editor |
|------|--------|
| `nova.vim`, `ftdetect_nova.vim` | Vim / Neovim |
| `nova.yaml` | micro |

## micro

Copy the syntax file into micro's config; it auto-detects `*.nova` via the
`detect:` rule, no extra setup:

```sh
mkdir -p ~/.config/micro/syntax
cp editors/nova.yaml ~/.config/micro/syntax/
```

## Vim

```sh
mkdir -p ~/.vim/syntax ~/.vim/ftdetect
cp editors/nova.vim          ~/.vim/syntax/nova.vim
cp editors/ftdetect_nova.vim ~/.vim/ftdetect/nova.vim
```

## Neovim

```sh
mkdir -p ~/.config/nvim/syntax ~/.config/nvim/ftdetect
cp editors/nova.vim          ~/.config/nvim/syntax/nova.vim
cp editors/ftdetect_nova.vim ~/.config/nvim/ftdetect/nova.vim
```

These are regex highlighters (keywords, types, constants, numbers, strings,
`//` and `/* */` comments, operators, and function names).

For GitHub, see the `linguist-language=C++` mapping in `.gitattributes` instead, GitHub only
highlights languages Linguist already ships.
