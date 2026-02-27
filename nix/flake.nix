{
  description = "Python development environment for LLMs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        # python packages
        python-with-packages = pkgs.python3.withPackages (ps: with ps; [
          openai
          # other packages here, as more LLMs are added
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            # Python with packages, for integrating python module with installed packages
            python-with-packages

            # Development tools
            pkgs.python3Packages.pip
            pkgs.python3Packages.virtualenv
          ];

          shellHook = ''
            echo "Python development environment with OpenAI"
            echo "Python version: $(python --version)"
            echo "To create a virtual environment (optional):"
            echo "  python -m venv .venv"
            echo "  source .venv/bin/activate"
          '';
        };
      });
}