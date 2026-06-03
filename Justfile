_host := 'my-vm'

rebuild:
    sudo nixos-rebuild switch --flake .#{{_host}}
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2
    nix-env --delete-generations +2 || true
    sudo nix-collect-garbage -d
    sudo nix-store --optimise

rebuild-x11:
    just _host=my-vm-x11 rebuild

update:
    cd ~/nixos && git pull
    sudo nixos-rebuild switch --flake .#{{_host}}
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2
    nix-env --delete-generations +2 || true
    sudo nix-collect-garbage
    sudo reboot

update-x11:
    just _host=my-vm-x11 update

upgrade:
    cd ~/nixos && nix flake update
    sudo nixos-rebuild switch --flake .#{{_host}}
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2
    nix-env --delete-generations +2 || true
    sudo nix-collect-garbage
    sudo reboot

upgrade-x11:
    just _host=my-vm-x11 upgrade

matrix:
    python3 scripts/module-matrix.py

clean keep='3':
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +{{keep}}
    sudo nix-env --delete-generations +{{keep}}
    nix-env --delete-generations +{{keep}} || true
    sudo nix-collect-garbage -d
    sudo nix-store --optimise
    sudo journalctl --vacuum-time=3d --vacuum-size=200M 2>/dev/null || true
    sudo rm -rf /nix/var/log/nix/drvs 2>/dev/null || true
    echo "Kept last {{keep}} generations, cleaned old builds + logs."

clean-all:
    sudo nix-collect-garbage -d
    sudo nix-store --gc
    sudo nix-store --optimise
    nix-env --delete-generations old || true
    sudo journalctl --vacuum-time=1d --vacuum-size=100M 2>/dev/null || true
    sudo rm -rf /nix/var/log/nix/drvs 2>/dev/null || true
    sudo rm -rf /tmp/nix-build-* 2>/dev/null || true
    echo "Full cleanup done."

