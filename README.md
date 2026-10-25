# Rebuilding

```bash
git add . # whenever you add or move files
```
```bash
nix run '.#write-flake' # when flake-parts.inputs changes
```
```bash
nh os test . # build and test the system
```
```bash
nh os boot . # add an option to boot into the current configuration
```
```bash
nh os switch . # do both test and boot
```

# Updating

To update upstream dependencies use-
```bash
nix flake update den # update your system
```
In order to add more system configuration, copy then rename `template.nix`. Further instructions are in the template.

# Debugging

If themes aren't working, see the [noctalia documentation](https://docs.noctalia.dev/noctalia/templates/official/gtk-qt/). Additionally, spotify requires a hard coded theme for reasons I can't be bothered to explain.

If a catastrophe happens you can always return to your previous commit with
```bash
git reset --hard
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
