# telescope-node-scripts.nvim
A telescope picker that runs scripts from your node package.json

## Required dependencies

* [jq](https://stedolan.github.io/jq/) (used for parsing JSON files)

## Installation

Using [packer.vim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'aburg/telescope-node-scripts.nvim',
  requires = { {'skywind3000/asyncrun.vim'} }
}
```

## Usage
```:lua require('telescope').extensions.nodescripts.pick()```

## TODO

* dropdown picker
