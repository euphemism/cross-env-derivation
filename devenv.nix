{ config, lib, pkgs, ... }:

let
  cross-env = import ./derivations/cross-env { inherit config lib pkgs; };
in
{
  packages = [ cross-env ];

  languages.javascript = {
    enable = true;

    npm.enable = true;
    
    package = pkgs.nodejs_20;
  };
}
