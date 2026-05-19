update:
    cd /etc/nixos && git pull
    sudo nixos-rebuild switch --flake /etc/nixos#my-vm
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +1
    nix-env --delete-generations +1 || true
    sudo nix-collect-garbage
    sudo reboot

debug:
    cd /etc/nixos && git pull
    sudo nixos-rebuild switch --flake /etc/nixos#my-vm --show-trace
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +1
    nix-env --delete-generations +1 || true
    sudo nix-collect-garbage
    sudo reboot
