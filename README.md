# Getting Started

If this is your first time booting this configuration, please preface any `nix` command with `NIX_CONFIG="extra-experimental-features = nix-command flakes pipe-operators" [nix command]`
e.g.
```bash
NIX_CONFIG="extra-experimental-features = nix-command flakes pipe-operators" nix run .#minipc -- test
```

You may replace `minipc` with your host name and `gmang` with your username.

# Rebuilding

```bash
git add . # whenever you add or move files
```
```bash
nix run .#write-flake # when flake-parts.inputs changes
```
```bash
nix run .#minipc -- test # build and test the system
```
```bash
nix run .#minipc -- boot # build and set as boot configuration
```
```bash
nix run .#vm # build and test the system in a VM
```

# Updating

```bash
nix flake update den # update your system
```

# Debugging

In the event of OOM crashing, use the following before rebuilding your configuration.

```bash
sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

If you get `home-manager_<user>.service` failed to launch check out your journal to see what's wrong. Usually it's a file conflict which can simply be resolved by `rm` it.

```bash
journalctl -n 50
```
```bash
rm -rf ~/.config/path/to/your/problem/file
```

If all else fails, you can return to your previous commit with
```bash
git reset --HARD
```

# Making a PR to share code

```bash
git add . # To make git aware of all your changes
```
```bash
git commit -m "A brief description of your changes" # To save all those changes
```
```bash
git push # To push your changes to your version
```
```bash
gh pr create # To push your changes to my version
```
