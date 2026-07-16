# Getting Started Guide

```fish
nix flake update den
git add . # whenever you add files
nix run .#write-flake # when flake-parts.inputs changes
nix run .#<laptop/desktop> -- test # build and test the system
nix run .#<laptop/desktop> -- boot # build and set as boot configuration
nix run .#vm # build and test the system in a VM
```
