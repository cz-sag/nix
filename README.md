# Nix systems repo

## Switch from running NixOS

```bash
sudo nixos-rebuild switch --flake .
```

## Install
```bash
cd /tmp
git clone https://github.com/cz-sag/nix.git
HOSTNAME=<generated hostname>

# Format disk
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/nix/hosts/${HOSTNAME}/disko-config.nix

#sudo nixos-generate-config --no-filesystems --root /mnt
sudo nixos-install -v --show-trace --no-root-passwd --root /mnt --flake /tmp/nix#${HOSTNAME}
```

## Initialize
```bash
nix flake init --extra-experimental-features 'nix-command flakes'
curl https://raw.githubusercontent.com/nix-community/disko/master/example/hybrid.nix -o /tmp/disk-config.nix
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disk-config.nix
nixos-generate-config --no-filesystems --root /mnt
```

namegen: https://codepen.io/mikedryan/details/vLrgqr
