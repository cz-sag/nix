switch:
  sudo nixos-rebuild --flake . switch

test:
  sudo nixos-rebuild --show-trace --flake . test

format:
  sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/nix/hosts/${HOSTNAME}/disko-config.nix

install:
  sudo nixos-install -v --show-trace --no-root-passwd --root /mnt --flake /tmp/nix#${HOSTNAME}

add:
  nix fmt
  git add .
