# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, user, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration-zfs.nix ./zfs.nix
    ];


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp34s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = with pkgs; [ fcitx5-rime ];
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  nixpkgs.config.allowUnfree = true;
  programs.thefuck.enable = true;  
  fonts.fonts = with pkgs; [
    source-code-pro
    font-awesome
    corefonts
    (
      nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      }
    )
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  services.xserver.screenSection = ''
    Option         "metamodes" "HDMI-0: 2560x1080_144 +0+550, DP-0: 2560x1440_144 +2560+0"
    Option         "AllowIndirectGLXProtocol" "off"
    Option         "TripleBuffer" "on"

  '';

  # Enable the Plasma 5 Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager = {                          # Display Manager
    lightdm = {
      enable = true;                          # Wallpaper and gtk theme
      #background = pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
      greeters = {
        gtk = {
          theme = {
            #name = "Dracula";
            #package = pkgs.dracula-theme;
            name = "Dracula";
            package = pkgs.dracula-theme;
          };
          cursorTheme = {
            name = "Dracula-cursors";
            package = pkgs.dracula-theme;
            size = 16;
          };
        };
      };
    };
    defaultSession = "none+bspwm";
  };
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.windowManager.bspwm.package = pkgs.bspwm;

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  #hardware.pulseaudio.extraConfig = "unload-module module-jack-sink\nunload-module module-jack-source\nunload-module module-loopback\nsleep 0.5\nload-module module-jack-source channels=2 source_name=Discord client_name=Discord connect=no\nload-module module-jack-source channels=2 source_name=Internal client_name=Internal connect=no\nload-module module-jack-source channels=2 source_name=Mix_all client_name=Mix_all connect=no\nload-module module-jack-source channels=2 source_name=Media_pipe client_name=Media_pipe connect=no\nload-module module-jack-sink channels=2 sink_name=System client_name=System connect=no\nload-module module-jack-sink channels=2 sink_name=Web client_name=Web connect=no\nload-module module-jack-sink channels=2 sink_name=Media client_name=Media connect=no\nload-module module-jack-sink channels=2 sink_name=Other client_name=Other connect=no\nload-module module-loopback source=Media_pipe sink=Media";
  services.jack = {
    jackd.enable = true;
    jackd.extraOptions = [ "-dalsa" "-dhw:iD14" "-r44100" "-p128" ];
    # support ALSA only programs via ALSA JACK PCM plugin
    alsa.enable = true;
    # support ALSA only programs via loopback device (supports programs like Steam)
    #loopback = {
      #enable = true;
      # buffering parameters for dmix device to work with ALSA only semi-professional sound programs
      #dmixConfig = ''
      #  period_size 2048
      #'';
    #};
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jaus = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "jackaudio" "video" "lp" "networkmanager" "kvm" "libvirtd" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    lm_sensors
    killall
    pciutils
    usbutils
    git
    ntfs3g
    firefox
  ];
  
  environment.variables.EDITOR = "nvim";

  nixpkgs.overlays = [
    (
      self: super: {
        neovim = super.neovim.override {
	  viAlias = true;
	  vimAlias = true;
	};
      }
    )
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
  
  nix = {
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };
}

