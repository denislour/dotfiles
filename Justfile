_host := 'my-vm'

rebuild:
    sudo nixos-rebuild switch --flake .#{{_host}}
    sudo nix-collect-garbage -d
    sudo nix-store --optimise

rebuild-x11:
    just _host=my-vm-x11 rebuild

update:
    git pull
    sudo nixos-rebuild switch --flake .#{{_host}}
    sudo nix-collect-garbage -d
    sudo nix-store --optimise

update-x11:
    just _host=my-vm-x11 update

update-reboot:
    just update
    sudo reboot

upgrade:
    nix flake update
    sudo nixos-rebuild switch --flake .#{{_host}}
    sudo nix-collect-garbage -d
    sudo nix-store --optimise

upgrade-x11:
    just _host=my-vm-x11 upgrade

upgrade-reboot:
    just upgrade
    sudo reboot

clean keep='2':
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +{{keep}}
    nix-env --delete-generations +{{keep}} || true
    sudo nix-collect-garbage -d
    sudo nix-store --optimise
    sudo journalctl --vacuum-time=3d --vacuum-size=200M 2>/dev/null || true
    sudo rm -rf /nix/var/log/nix/drvs 2>/dev/null || true
    echo "kept last {{keep}} generations"

clean-all:
    sudo nix-collect-garbage -d
    sudo nix-store --optimise
    nix-env --delete-generations old || true
    sudo journalctl --vacuum-time=1d --vacuum-size=100M 2>/dev/null || true
    sudo rm -rf /nix/var/log/nix/drvs 2>/dev/null || true
    sudo rm -rf /tmp/nix-build-* 2>/dev/null || true
    echo "full cleanup done"
