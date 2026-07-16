# Getting Started Guide

```fish
nix flake update den
git add . # whenever you add files
nix run .#write-flake # when flake-parts.inputs changes
nix run .#<laptop/desktop> -- test # build and test the system
nix run .#<laptop/desktop> -- boot # build and set as boot configuration
nix run .#vm # build and test the system in a VM
```



# pass any other nh action
nix run .#igloo -- switch
```

- Run the VM

We recommend to use a VM develop cycle so you can play with the system before applying to your hardware.

See [modules/vm.nix](modules/vm.nix)

```console
nix run .#vm
```
