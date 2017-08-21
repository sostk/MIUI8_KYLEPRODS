#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 8654848 abcc970a70884d68bfde9e82c0914cd840c5ca54 6090752 6be53b6d536df02a98781ab183c5e77d04792a7f
fi

if ! applypatch -c EMMC:/dev/block/platform/sdhci.1/by-name/RECOVERY:8654848:abcc970a70884d68bfde9e82c0914cd840c5ca54; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/sdhci.1/by-name/KERNEL:6090752:6be53b6d536df02a98781ab183c5e77d04792a7f EMMC:/dev/block/platform/sdhci.1/by-name/RECOVERY abcc970a70884d68bfde9e82c0914cd840c5ca54 8654848 6be53b6d536df02a98781ab183c5e77d04792a7f:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
