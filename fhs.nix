{ config, pkgs, lib, ... }:

{
  # ......omit many configurations

  environment.systemPackages = with pkgs; [
    # ......omit many packages

    # Create an FHS environment using the command `fhs`, enabling the execution of non-NixOS packages in NixOS!
    (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSUserEnv (base // {
      name = "fhs";
      targetPkgs = pkgs: (base.targetPkgs pkgs);
      multiPkgs = pkgs: (with pkgs; [
        # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
        # lacking many basic packages needed by most software.
        # Therefore, we need to add them manually.
        #
        # pkgs.appimageTools provides basic packages required by most software.
          pkg-config
          ncurses
          # Feel free to add more packages here if needed.
	  glibc
	  gcc
	  zlib
	  libxml2
	  gtk2
	  gtk3
	  xorg.libX11
	  xorg.libXrandr
	  xorg.libXtst
	  xorg.libXext
	  xorg.libSM
	  xorg.libICE
	  fontconfig
	  freetype
	  python3
	  curl
	  openssl
	  fuse
	  bash
	  linuxPackages.kernel
	  kmod
	  libaio  
	  libpng  
	  libcanberra 
	  pcsclite  
	  lvm2  
	  binutils
        ]
      );
      profile = "export FHS=1";
      runScript = "bash";
      extraOutputsToInstall = ["dev"];
      extraBwrapArgs = [
          "--unsetenv NO_NEW_PRIVS"  # Unset no_new_privs flag
          "--setenv NO_NEW_PRIVS 0"  # Explicitly set to 0
      ];
    }))
  ];

  # ......omit many configurations
}
