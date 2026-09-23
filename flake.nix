{
  description = "Odds Nix configs for work setups";

  nixConfig = {
    extra-substituters = [
      "https://cache.lix.systems"
      "https://cache.nixos.org/"
    ];
    extra-trusted-public-keys = [
      "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    connect-timeout = 5;
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixvim.url = "github:nix-community/nixvim";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixvim,
      home-manager,
      sops-nix,
      ...
    }@inputs:
    let
      allSystems = nixpkgs.lib.systems.flakeExposed;
      forSystems = systems: f: nixpkgs.lib.genAttrs systems (system: f system);

    in
    {
      devShells = forSystems allSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              git
              nil # lsp language server for nix
              nix-output-monitor
              nixpkgs-fmt
              sops
            ];
          };
        }
      );

      # Bootstrap a config with something like the following:
      # nix --extra-experimental-features 'nix-command flakes' --accept-flake-config develop
      # sudo nixos-rebuild switch --accept-flake-config --flake .#orbnix

      nixosConfigurations =
        let
          primaryUser = "oddee";
        in
        {

          # Test system in Orbstack on macOS
          orbnix =
            let
              sys = "aarch64-linux";
              hostname = "orbnix";
            in
            nixpkgs.lib.nixosSystem {
              system = sys;
              specialArgs = inputs;
              modules = [
                (import ./hosts/orbnix/system.nix {
                  inherit primaryUser;
                  inherit sys;
                  inherit hostname;
                })
                ./hosts/orbnix/programs.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    backupFileExtension = "bak";
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = {
                      inherit
                        inputs
                        primaryUser
                        sys
                        ;
                    };
                    users.${primaryUser}.imports = [ ./hm ];
                  };
                }
              ];
            };

        };
    };
}
