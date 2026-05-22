rebuild:
    sudo nixos-rebuild switch --flake .#my-vm

update:
    cd ~/nixos && git pull
    sudo nixos-rebuild switch --flake .#my-vm
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +1
    nix-env --delete-generations +1 || true
    sudo nix-collect-garbage
    sudo reboot

upgrade:
    cd ~/nixos && nix flake update
    sudo nixos-rebuild switch --flake .#my-vm
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +1
    nix-env --delete-generations +1 || true
    sudo nix-collect-garbage
    sudo reboot

clean keep=3:
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +{{keep}}
    sudo nix-env --delete-generations +{{keep}}
    nix-env --delete-generations +{{keep}} || true
    sudo nix-collect-garbage -d
    sudo nix-store --optimise
    echo "✅ Kept last {{keep}} generations, cleaned old builds."

clean-all:
    sudo nix-collect-garbage -d
    sudo nix-store --gc
    sudo nix-store --optimise
    nix-env --delete-generations old || true
    echo "✅ Full cleanup done."

