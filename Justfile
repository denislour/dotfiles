rebuild:
    sudo nixos-rebuild switch --flake .#my-vm
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2
    nix-env --delete-generations +2 || true
    sudo nix-collect-garbage -d
    sudo nix-store --optimise

update:
    cd ~/nixos && git pull
    sudo nixos-rebuild switch --flake .#my-vm
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2
    nix-env --delete-generations +2 || true
    sudo nix-collect-garbage
    sudo reboot

upgrade:
    cd ~/nixos && nix flake update
    sudo nixos-rebuild switch --flake .#my-vm
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2
    nix-env --delete-generations +2 || true
    sudo nix-collect-garbage
    sudo reboot

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

# Check VM storage: inside VM vs host disk file bloat
vm-check:
    @echo "=== Disk usage inside VM ==="
    df -h /
    @echo ""
    @echo "=== Biggest dirs ==="
    -du -sh /nix/store /home /var 2>/dev/null
    @echo ""
    @echo "Kiem tra host disk file (.vmdk) size ben Windows."
    @echo "Neu host file > VM used +5G => can compact."
    @echo ""
    @echo "Compact: VM Settings -> Hard Disk -> Compact"

