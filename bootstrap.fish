NIX_CONFIG="experimental-features = nix-command flakes pipe-operators"\
nix run .#desktop -- test
