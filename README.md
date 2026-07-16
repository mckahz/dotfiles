# Getting Started

If this is your first time booting this configuration, please preface any `nix` command with `NIX_CONFIG="extra-experimental-features = nix-command flakes pipe-operators" [nix command]`

```fish
nix flake update den
git add . # whenever you add or move files
nix run .#write-flake # when flake-parts.inputs changes
nix run .#<hostname> -- test # build and test the system
nix run .#<hostname> -- boot # build and set as boot configuration
nix run .#vm # build and test the system in a VM
```

# Debugging

In the event of OOM crashing, use the following before rebuilding your configuration.

```bash
sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

If you get `home-manager_<username>.service` failed to launch check out your journal to see what's wrong. Usually it's a file conflict which can simply be resolved by `rm` it.

```bash
journalctl -n 50
```
