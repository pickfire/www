Performance is the King!
========================

Speed up the slow systemd
-------------------------
- Do **simple benchmark**
    systemd-analyze [time|blame|critical-chain]
- Enable `.socket` and disable `.service` (eg. sshd)
- Set `Storage=volatile` in /etc/systemd/journald.conf

#### **Kernel**: https://wiki.archlinux.org/index.php/Minimal_initramfs
