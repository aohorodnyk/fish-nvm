# Fish NVM: Seamless NVM integration for the Fish shell

Fish NVM is a lightweight, minimalist package that integrates the [Node Version Manager (NVM)](https://github.com/nvm-sh/nvm) into the [Fish shell](https://fishshell.com/), enabling smoother Node.js workflow for Fish users.

## Key Features

Fish NVM is designed to perform the bare necessities required to harmonize NVM with the Fish shell. Here are its core features:

* Augments Fish with `nvm` and `nvm_find_nvmrc` functions.
* Automatically detects and loads the Node.js version specified in the `.nvmrc` file in the current directory or any parent directory.
* If the required Node.js version specified in the `.nvmrc` file isn't installed yet, it triggers the installation process.
* Closer directory traversal: Fish NVM searches for the `.nvmrc` file in the current directory first, then in the parent directory, and so on, until it reaches the root directory.

## Getting Started

Before you install Fish NVM, make sure [NVM](https://github.com/nvm-sh/nvm) is installed on your system. If you haven't installed it yet, you can do so using [Homebrew](https://brew.sh):

```sh
brew install nvm
```

Once NVM is ready, install the Fish NVM package using [Fisher](fisher):

```sh
fisher install aohorodnyk/fish-autovenv
```

Fish NVM relies on the [Bass](https://github.com/edc/bass) package for optimum performance. Install it with Fisher:

```sh
fisher install edc/bass
```

## Usage

After successful installation, Fish NVM operates automatically. Whenever you navigate into a directory containing a `.nvmrc` file (either in the current directory or any parent directory), Fish NVM auto-detects and loads the required version of Node.js. If the required version isn't installed, Fish NVM initiates the installation process.
