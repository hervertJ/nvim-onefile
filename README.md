# nvim-one-file

Only one file config nvim.

## Requirements

- Neovim `0.12` or later

- A [Nerd Font](https://www.nerdfonts.com/) (optional)

- `ripgrep`, `fzf`, `fd`

- Rust tools for `blink.cmp`

- tree-sitter package and tree-sitter-cli in path

> [!NOTE]
> LSP servers are managed via [Mason](https://github.com/mason-org/mason.nvim).

> [!WARNING]
> In NixOS you should **NOT** use Mason, install LSPs in `home.nix` or `configuration.nix`.
