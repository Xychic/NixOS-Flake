# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:
{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    nixPath = [ "/etc/nix/path" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
  environment.etc."/nix/path/nixpkgs".source = inputs.nixpkgs;
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        default = 2;
        extraConfig = ''
          GRUB_CMDLINE_LINUX_DEFAULT="quiet splash video=USB-C-0:D"
        '';
      };
      grub2-theme = {
        theme = "vimix";
      };
    };
  };

  networking = {
    hostName = "ncase"; # Define your hostname.
    networkmanager.enable = true;
  };
  hardware.graphics.enable = true;

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  fileSystems = {
    "/mnt/data" = {
      device = "/dev/disk/by-uuid/E8C0-C177";
      fsType = "exfat";
      options = [
        "rw"
        "uid=1000"
        "gid=100"
        "umask=0077"
        "nofail"
      ];
    };
    "/mnt/steam" = {
      device = "/dev/disk/by-uuid/8A60D90260D8F643";
      fsType = "ntfs";
      options = [
        "rw"
        "uid=1000"
        "nofail"
      ];
    };
    "/mnt/docker" = {
      device = "/dev/disk/by-uuid/9ffa4c99-3fd1-4272-b79d-cdad08d749a8";
      fsType = "ext4";
      options = [ "nofail" ];
    };
    "/mnt/scratch" = {
      device = "/dev/disk/by-uuid/7ea8901d-a5d3-47ae-929c-638a96bf30dc";
      fsType = "ext4";
      options = [ "nofail" ];
    };
  };
  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    useDHCP = false;
    interfaces = {
      enp4s0.useDHCP = true;
      wlp5s0.useDHCP = true;
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # NVIDIA drivers are unfree.
  nixpkgs.config.allowUnfree = true;
  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];

      # Enable the X11 windowing system.
      enable = true;

      # Enable the Plasma 5 Desktop Environment.
      desktopManager.plasma5.enable = true;
    };
    displayManager.sddm.enable = true;
  };
  hardware.nvidia.open = false;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # hardware.pulseaudio.enable = true;
  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jacob = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "docker"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh = {
    shellInit = "export PKG_CONFIG_PATH=${pkgs.openssl.dev}/lib/pkgconfig";
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;

    shellAliases = import ../../home/cli/core/zsh/aliases.nix;

    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  virtualisation.docker.enable = true;
  virtualisation.docker.extraOptions = "--data-root /mnt/docker";

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
  system.stateVersion = "21.11"; # Did you read the comment?
}
