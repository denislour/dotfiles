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

# Check VM disk usage vs actual usage (to know if compact needed)
vm-disk:
    echo "=== Trong VM ==="
    df -h /
    du -sh /nix/store 2>/dev/null
    du -sh /home 2>/dev/null
    echo ""
    echo "Disk dang dung: $$(df -h / | tail -1 | awk '{print $$3}')"
    echo "Disk file ben host se lon hon do ko trim duoc."
    echo ""
    echo "Tren HOST (Windows), chay:"
    echo '  "C:\Program Files\VMware\VMware Workstation\vmware-vdiskmanager.exe" -k "<path>.vmdk"'
    echo ""
    echo "Hoac: VM Settings -> Hard Disk -> Compact"

