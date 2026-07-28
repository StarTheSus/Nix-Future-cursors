{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    inkscape
    xcursorgen
    zsh
  ];

  shellHook = ''
    exec ${pkgs.zsh}/bin/zsh
  '';
}
