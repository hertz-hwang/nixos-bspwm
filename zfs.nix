{ config, pkgs, ... }:

{ boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "7471856f";
  boot.zfs.devNodes = "/dev/disk/by-id";
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.kernelParams = [
    "zfs.zfs_arc_min=268435456"
    "zfs.zfs_arc_max=536870912"
  ];
  swapDevices = [
    { device = "/dev/disk/by-id/nvme-SAMSUNG_MZVLB256HBHQ-000L2_S4DXNF0MA26952-part4"; randomEncryption.enable = true; }
  ];
  services.zfs.autoScrub.enable = true;
  systemd.services.zfs-mount.enable = false;
  environment.etc."machine-id".source = "/state/etc/machine-id";
  environment.etc."zfs/zpool.cache".source
    = "/state/etc/zfs/zpool.cache";
  boot.loader.efi.efiSysMountPoint = "/boot/efis/nvme-SAMSUNG_MZVLB256HBHQ-000L2_S4DXNF0MA26952-part1";
  boot.loader.efi.canTouchEfiVariables = false;
  ##if UEFI firmware can detect entries
  #boot.loader.efi.canTouchEfiVariables = true;

  boot.loader = {
    generationsDir.copyKernels = true;
    ##for problematic UEFI firmware
    grub.efiInstallAsRemovable = true;
    grub.enable = true;
    grub.version = 2;
    grub.copyKernels = true;
    grub.efiSupport = true;
    grub.zfsSupport = true;
    # for systemd-autofs
    grub.extraPrepareConfig = ''
      mkdir -p /boot/efis
      for i in  /boot/efis/*; do mount $i ; done
    '';
    grub.extraInstallCommands = ''
       export ESP_MIRROR=$(mktemp -d -p /tmp)
       cp -r /boot/efis/nvme-SAMSUNG_MZVLB256HBHQ-000L2_S4DXNF0MA26952-part1/EFI $ESP_MIRROR
       for i in /boot/efis/*; do
        cp -r $ESP_MIRROR/EFI $i
       done
       rm -rf $ESP_MIRROR
    '';
    grub.devices = [
      "/dev/disk/by-id/nvme-SAMSUNG_MZVLB256HBHQ-000L2_S4DXNF0MA26952"
    ];
  };
  #networking.interfaces.enp1s0.useDHCP = true;
  boot = {
    initrd.network = {
      enable = true;
      ssh = {
        enable = true;
        hostKeys = [ /state/etc/ssh/ssh_host_initrd_ed25519_key ];
        authorizedKeys = [ "" ];
      };
      postCommands = ''
        echo "zfs load-key -a; killall zfs" >> /root/.profile
      '';
    };
  };
  users.users.root.initialHashedPassword = "$6$e2URq6SWj6XLhQ29$Mo6YvBsT5qSxHJ2B2y6gtkQ7sSBY4NJd6dT/ZAnFmwyEBtIw/BzUE5cmkSbUbDWeJQnym5LhQBb204Fke/zZA/";
}
