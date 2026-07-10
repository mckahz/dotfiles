{ lib, ... }:
let
  loadDir =
    dir:
    let
      files = builtins.readDir ./${dir};
    in
    lib.attrsets.mapAttrsToList (name: type: ./${dir}/${name}) (
      lib.attrsets.filterAttrs (
        name: type: type == "regular" && lib.strings.hasSuffix ".nix" name && name != "default.nix"
      ) files
    );
in
{
  imports = loadDir "config" ++ loadDir "plugins";

  nixpkgs.config.allowUnfree = true;
}
