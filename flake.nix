{
  description = "Future cursor imported to nix";

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
        in
        {
          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "future-hyprcursor-collection";
            version = "1.0.0";

            src = ./.;

            installPhase = ''
              runHook preInstall

              mkdir -p $out/share/icons/Future-cyan-cursors

              cp -r ./dist/* $out/share/icons/Future-cyan-cursors/

              runHook postInstall
            '';

            meta = with pkgs.lib; {
              description = "Future cursor imported to nix";
              license = licenses.gpl3;
              platforms = platforms.linux;
            };
          };
        }
      );
    };
}
