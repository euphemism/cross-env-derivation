{ config, lib, pkgs, ... }:

pkgs.buildNpmPackage rec {
  pname = "cross-env";
  version = "7.0.3";

  src = pkgs.fetchFromGitHub {
    owner = "kentcdodds";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-XwmzEdlUok+GvF7DM6q7v9EXXetkA4RvMl/8EbXoEhw=";
  };

  patches = [ ./0001-Add-package-lock.json.patch ];

  dontNpmBuild = true; # cross-env doesn't have a build step
  dontNpmPrune = true;

  npmDepsHash = "sha256-/8iEGx+euVzjSMVpi4kUs+CuZKn2zUs8oz0GSqcgP8c=";

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = [ "--ignore-scripts" ];

  NODE_OPTIONS = "--openssl-legacy-provider";

  nodejs = config.languages.javascript.package;

  meta = {
    hash = "sha256-jIILrh7OBMOlgJvsuaX+RjDdunsvFi6wkit5tKu9o0g=";

    description = "Run scripts that set and use environment variables across platforms";
    homepage = "https://github.com/kentcdodds/cross-env";
    license = lib.licenses.mit;
  };
}
