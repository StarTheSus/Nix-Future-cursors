# Future cursors
This is an xcursor theme, that was forked and ported to Nix. The fork is from [Future-cursor](https://github.com/yeyushengfan258/Future-cursors?tab=readme-ov-file) x-cursor theme, which itself was inspired by macOS and based on [capitaine-cursors](https://github.com/keeferrourke/capitaine-cursors).

## Installation

Add the input to your nix flake:

```nix
inputs = {
    # ... your existing inputs ...

    future-cursors = {
      url = "github:StarTheSus/Nix-Future-cursors";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
```

And reflect it in your outputs:

```nix
outputs =
  inputs@{
    self,
    nixpkgs,
    # ... your existing outputs ...

    future-cursors,
    ...
  }:
```

## Usage

You can add the input by importing inputs and grabbing the package:

```nix
{ config, pkgs, inputs, ... }: # <-- Make sure 'inputs' is listed here

{
  # ... your config ...

  environment.systemPackages = [
    inputs.future-cursors.packages.${pkgs.system}.default
    # Replace `default` with any desired color available (orange | cyan)
  ];

  # How I configure it for my niri, optional.
  environment.variables = {
    XCURSOR_THEME = "Future-cyan-cursors";
    XCURSOR_SIZE = "24";
    XCURSOR_PATH = "/run/current-system/sw/share/icons";
  };
}
```

## Imperative Installation [UNRECOMMENDED]
**Note**: This section is left as is from the original repository, nix is not designed to work imperatively, it is expected to always configure it declaratively. This is kept for those who need it.

To install the cursor theme simply copy the compiled theme to your icons
directory. For local user installation:

```bash
./install.sh
```

For system-wide installation for all users:

```bash
sudo ./install.sh
```

Then set the theme with your preferred desktop tools.

## Building from source
You'll find everything you need to build and modify this cursor set in
the `src/` directory. To build the xcursor theme from the SVG source
run:

```bash
nix-shell  # Don't forget to edit it if you prefer bash

cp -r src/svg-cyan src/svg  # Replace "cyan" with any color you like under src

./build.sh

rm -rf src/svg
```

This will generate the pixmaps and appropriate aliases.
The freshly compiled cursor theme will be located in `dist/`

If you update the flake, don't forget to update the lock file:

```bash
nix flake lock
```
```
```

## Preview
![Future](preview.png)
![Future](preview-1.png)
