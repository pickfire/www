Performance is the King!
========================

Speed up the slow systemd
-------------------------
- Do **simple benchmark**
    systemd-analyze [time|blame|critical-chain]
- Enable `.socket` and disable `.service` (eg. sshd)
- Set `Storage=volatile` in /etc/systemd/journald.conf

#### **Kernel**: https://wiki.archlinux.org/index.php/Minimal_initramfs
- For a better boost in boot time, remove the initramfs if no luks/lvm/raid is
  used and compile linux kernel to include the modules needed in boot
- Or instead, minimal initramfs (mkinitcpio here)

    MODULES="ahci sd_mod btrfs"
    HOOKS="base"

Speeding up DNS
---------------
- One-liner to find fastest DNS server and add to `resolv.conf` ([commandlinefu](http://www.commandlinefu.com/commands/view/18802/a-function-to-find-the-fastest-dns-server)):

    curl -s http://public-dns.info/nameservers.txt | xargs -i timeout 1 ping -c1 -w 1 {} | sed -n "/:.*time/ s/.*from \([^:]*\).*time=\([^ ]*\).*/\2\t\1/p" | sort -n | head -n1
