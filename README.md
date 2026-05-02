# Multiclonage

![Multiclonage](./assets/naruto-multiclonage.png)

This repo contains the configuration files for my different machines, as well as the scripts to set them up. The idea is to have a single source of truth for all my configurations, and to be able to easily set up a new machine by running a single script.

As I'm "stuck" with Ubuntu for the foreseeable future, all the configurations are tailored for it, but they should be easily adaptable to other distributions.

## TL;DR

To set up a new machine, simply run the secret jutsu :

```bash
git clone https://github.com/tlap9/multiclonage.git
cd multiclonage
./multiclonage.sh
```

## Inspiration

After some drawback trying to configure Nix and home-manager for Ubuntu - too much tweaks for the sake of it, I decided to go with a more traditional approach after reading this article : [From NixOS to Ubuntu](https://jnsgr.uk/2025/06/from-nixos-to-ubuntu/).
