# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };

  # programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
  
  #########################
  # GREY'S CONFIGURATIONS #
  #########################
  # hardware
  hardware.firmware = [ pkgs.linux-firmware ];

  # Keyboard layout ^-^
  services.xserver.xkb.layout = "us";
  # User :D
  users.users.grey = {
	isNormalUser = true;
	description = "9r3y";
	extraGroups = [ 
          "wheel"
          "networkmanager"  
        ];
	shell = pkgs.bash;
	home = "/home/grey";
  };
  # networking

  # Boot
  boot.loader.grub.device = "nodev";
  boot.kernelModules = [ "iwlwifi" ];

  # Packages   

  environment.systemPackages = [ 
    pkgs.vim
    pkgs.firefox
    pkgs.firefox-wayland
    pkgs.curl
    pkgs.htop
    pkgs.hyprland
    pkgs.hyprlock
    pkgs.hypridle 
    pkgs.kitty
    pkgs.foot
    pkgs.pciutils
    pkgs.waybar
    pkgs.hyprpaper
    pkgs.wofi
    pkgs.neovim
    pkgs.xdg-utils
    pkgs.xdg-desktop-portal
    pkgs.xdg-desktop-portal-wlr
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland
    pkgs.wlr-randr
    pkgs.wl-clipboard
    pkgs.hyprland-protocols
    pkgs.grim
    pkgs.slurp
    pkgs.uwsm
    pkgs.nwg-look
    pkgs.fastfetch
    pkgs.fcitx5
    pkgs.fcitx5-gtk
    pkgs.git
    pkgs.gcc
    pkgs.adwaita-qt
    pkgs.adwaita-qt6
    pkgs.zip
    pkgs.unzip
    pkgs.noto-fonts-cjk-sans
    pkgs.dejavu_fonts
    pkgs.font-awesome
  ];

  # hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;   
  };

  environment.sessionVariables = {
  # electron apps to use wayland
  NIXOS_OZONE_WL = "1";
  # if cursor becomes transparent
  #WLR_NO_HARDWARE_CURSORS = "1";
  };

  hardware = {
    graphics.enable = true;
  };
  # XDG
  xdg.autostart.enable = true;
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = [ 
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-hyprland 
  ];
  xdg.portal.config = {
    hyprland = {
      default = [ "hyprland" ];
    };
  };

  # Pipewire
  #sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Fonts
  fonts.packages = [	
    pkgs.dejavu_fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.font-awesome
  ];
}
