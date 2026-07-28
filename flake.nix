{
  description = "Future cursors imported to nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          mkCursor =
            color:
            pkgs.stdenvNoCC.mkDerivation {
              pname = "future-${color}-cursors";
              version = "1.0.0";

              src = ./.;
              installPhase = ''
                runHook preInstall

                # (e.g., Future-cyan-cursors, Future-orange-cursors)
                mkdir -p $out/share/icons/Future-${color}-cursors

                # Pull from the specific color's output directory
                cp -r ./output/${color}/* $out/share/icons/Future-${color}-cursors/

                runHook postInstall
              '';

              meta = with pkgs.lib; {
                description = "Future ${color} cursor imported to nix";
                license = licenses.gpl3;
                platforms = platforms.linux;
              };
            };
        in
        {
          # call the function for each color to expose
          cyan = mkCursor "cyan";
          orange = mkCursor "orange";

          # set 'cyan' as the default package if none are specified
          default = mkCursor "cyan";
        }
      );
    };
}
