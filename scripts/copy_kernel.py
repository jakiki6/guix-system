import os, re, shutil, sys, tempfile

efi = os.path.isdir("/sys/firmware/efi")

if os.getuid() != 0:
    print("[!] I need root")
    exit(1)

copied = set()
def copy(path):
    global copied

    if path in copied:
        return

    copied.add(path)

    os.makedirs(os.path.dirname(os.path.join("/boot", path[1:])), exist_ok=True)
    if os.path.isdir(path):
        shutil.copytree(path, os.path.join("/boot/", path[1:]))
    else:
        shutil.copy(path, os.path.join("/boot/", path[1:]))

links = []
p = re.compile("system-[0-9]+-link")
for entry in os.listdir("/var/guix/profiles"):
    if p.match(entry):
        links.append(os.path.join("/var/guix/profiles", entry))

print(f"[*] Found {len(links)} system profile" + ("s" if len(links) !=0 else ""))

if os.path.isdir("/boot/gnu"):
    print("[*] Deleting old /boot/gnu")
    shutil.rmtree("/boot/gnu")

for entry in links:
    kernel = os.readlink(os.readlink(os.path.join(entry, "kernel/bzImage")))
    initrd = os.readlink(os.path.join(entry, "initrd"))

    print(f"[*] Copying entry with kernel={kernel} and initrd={initrd}")
    copy(kernel)
    copy(initrd)

with open("/boot/grub/grub.cfg", "r") as f:
    content = f.read()

lines = content.split("\n")
p = re.compile(".*(\\/gnu\\/store\\/[a-zA-Z0-9_\\-.+\\/]+(grub-image\\.png|grub-locales|grub-keymap.[a-z]+|gnumach|memtest.bin)).*")
for line in lines:
    match = p.match(line)

    if match:
        print(f"[*] Copying {match.group(1)}")
        copy(match.group(1))

if "# patched already\n" in content:
    print("grub.cfg is already patched")
else:
    with open("/boot/grub/grub.cfg.old", "w") as f:
        f.write(content)

    print("Patching grub.cfg")

    while not lines[0].startswith("# Set 'root' to the partition that contains /gnu/store."):
        lines.pop(0)

    lines.pop(0)
    lines.pop(0)
    lines.pop(0)

    for i in range(0, len(lines)):
        if "search --label --set" in lines[i]:
            if not efi and "boot" in lines[i]:
                continue

            lines[i] = lines[i].replace("search", "# search")

    lines.insert(0, "# patched already")

    for i in range(0, len(lines)):
        if lines[i] == "set timeout=5":
            c = lines[i+1:i+7]

            c[0] = "menuentry \"Kernel dev\" {"
            c[2] = c[2].split(" ")
            c[2][3] = "/kernel"
            c[2] = " ".join(c[2])

            for j in range(len(c) - 1, -1, -1):
                lines.insert(i + 7, c[j])

        if "memtest" in lines[i] and "multiboot" in lines[i]:
            lines[i] = lines[i].replace("multiboot", "linux")

    content = "\n".join(lines)

    with open("/boot/grub/grub.cfg", "w") as f:
        f.write(content)

if efi:
    print("Building grub image")

    tempdir = tempfile.TemporaryDirectory()
    os.chdir(tempdir.name)

    if os.path.isfile("/boot/EFI/BOOT/BOOTX64.EFI"):
        os.system("mv /boot/EFI/BOOT/BOOTX64.EFI /boot/EFI/BOOT/BOOTX64.EFI.OLD")

    os.system("grub-mkstandalone -O x86_64-efi --directory=$(guix build grub-efi)/lib/grub/x86_64-efi --modules $(find /boot/grub | grep \\\\.mod$ | cut -d/ -f5 | cut -d. -f1) --output /boot/EFI/BOOT/BOOTX64.EFI \"boot/grub/grub.cfg=/boot/grub/grub.cfg\" \"gnu=/boot/gnu\"")

    os.system("sbctl sign /boot/EFI/BOOT/BOOTX64.EFI")
    os.system("sync")

print("Done")
