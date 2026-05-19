update:
    cd ~/nixos && git pull
    sudo nixos-rebuild switch --flake .#my-vm
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +1
    nix-env --delete-generations +1 || true
    sudo nix-collect-garbage
    sudo reboot

debug:
    cd ~/nixos && git pull
    sudo nixos-rebuild switch --flake .#my-vm --show-trace
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +1
    nix-env --delete-generations +1 || true
    sudo nix-collect-garbage
    sudo reboot
