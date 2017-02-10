Flashing and Rooting RedMi Note 3
=================================

I have wanted to root the RedMi Note 3 （红米3）. Looking into the tutorials
online, rooting with Linux for RedMi Note 3 does not seem to be an easy task.

Some useful guides helps, [unofficial rooting][twrp] and [miui thread][miui].
Hope this guide helps in flash + root RedMi Note 3 officially with Linux. ^^

How I root? Unlock the bootloader officially, flash with china developer rom
and then root it. Does it really worth it? The official su sucks so nope. :(

**Important**: Read this first, please note that Microsoft Windows is needed
for unlocking the bootloader for MiFlashUnlock, tried wine but does not work.

[twrp]: //www.androidsage.com/2016/04/09/root-install-twrp-redmi-note-3
[miui]: //www.miui.com/shuaji-393.html

Unlocking Bootloader
--------------------
Rooting does not work on global rom so I use develper rom. Specifically, the
China developer rom which does comes with china apps instead of google apps.

1. Request to unlock from [boot loader][ulbl].
2. Wait for few days (mine took 4 days).
3. Download and install the MiFlash on Windows.
4. Plug-in the phone and unlock it.

For mine, `红米Note3 全网通 最新 开发版`.

* 全网通 allows 电信、移动、联通 at the same time
* 开发版 is the developer rom

[ulbl]: //miui.com/unlock

Flashing Bootloader
-------------------
After bootloader has been unlocked, use a Linux computer to flash bootloader.

1. Get [device ID][udev] (`lsusb`) and add to udev rules
2. Goto fastboot: `adb reboot bootloader` or hold volume down + power on boot
3. Get `fastboot getvar product`, download rom on [miui][midl] (check name)
4. Boot to fastboot after enabled `Enable OEM Unlock` in developer options
5. After download, uncompress the rom file and run `sudo sh flash_all.sh`
6. **Note**: Data is gone after flashing

[udev]: //wiki.archlinux.org/index.php/Android#Figure_out_device_IDs
[midl]: //www.miui.com/shuaji-393.html

Setting up Device
-----------------
After flashing, there's a few things you would like to do:

* root the device - 安全中心 » 权限管理 » 开启ROOT权限
* install google play, apk install fails, use [谷歌安装器][goci]

[goci]: //www.gugeanzhuangqi.com
