import re
import glob

hosts = {}
for f in sorted(glob.glob('modules/hosts/*.nix')):
    host = f.split('/')[-1].replace('.nix', '')
    with open(f) as fh:
        content = fh.read()
    hm = sorted(set(re.findall(r'homeManager\.(\w+)', content)))
    os_mods = sorted(set(re.findall(r'nixos\.(\w+)', content)))
    os_mods = [m for m in os_mods if m not in ('home', 'my')]
    hosts[host] = {'hm': hm, 'os': os_mods}

names = list(hosts.keys())

print('=== NixOS Modules ===')
header = f'{"Module":25s}' + ' | '.join(f'{h:12s}' for h in names)
print(header)
print('-' * len(header))
all_os = sorted(set(m for h in hosts.values() for m in h['os']))
for mod in all_os:
    row = f'{mod:25s}'
    for h in names:
        row += f'{"✅" if mod in hosts[h]["os"] else "-":^12s}'
    print(row)

print()
print('=== Home-Manager Modules ===')
header = f'{"Module":25s}' + ' | '.join(f'{h:12s}' for h in names)
print(header)
print('-' * len(header))
all_hm = sorted(set(m for h in hosts.values() for m in h['hm']))
for mod in all_hm:
    row = f'{mod:25s}'
    for h in names:
        row += f'{"✅" if mod in hosts[h]["hm"] else "-":^12s}'
    print(row)
