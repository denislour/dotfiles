_host := 'my-vm'

rebuild:
    sudo nixos-rebuild switch --flake .#{{_host}}
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2
    nix-env --delete-generations +2 || true
    sudo nix-collect-garbage -d
    sudo nix-store --optimise

rebuild-lite:
    sudo nixos-rebuild switch --flake .#{{_host}}

rebuild-x11:
    just _host=my-vm-x11 rebuild

rebuild-x11-lite:
    just _host=my-vm-x11 rebuild-lite

update:
    git pull
    sudo nixos-rebuild switch --flake .#{{_host}}
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old
    nix-env --delete-generations old || true
    sudo nix-collect-garbage -d
    sudo nix-store --optimise
    sudo reboot

update-x11:
    just _host=my-vm-x11 update

clean:
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old
    nix-env --delete-generations old || true
    sudo nix-collect-garbage -d
    sudo nix-store --optimise
    sudo journalctl --vacuum-time=3d --vacuum-size=200M 2>/dev/null || true
    sudo rm -rf /nix/var/log/nix/drvs 2>/dev/null || true
    sudo /run/current-system/bin/switch-to-configuration boot 2>/dev/null

clean-x11:
    just _host=my-vm-x11 clean

clean-all:
    just clean

upgrade:
    nix flake update
    sudo nixos-rebuild switch --flake .#{{_host}}
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old
    nix-env --delete-generations old || true
    sudo nix-collect-garbage -d
    sudo nix-store --optimise
    sudo reboot

upgrade-x11:
    just _host=my-vm-x11 upgrade
