{ config, lib, pkgs, ... }:
{
  imports =
   [   ./hardware-configuration.nix
#        <nixos-hardware/lenovo/thinkpad/t480>
#        <home-manager/nixos>
];
nixpkgs = {
config.allowUnfree = true;
config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
};

boot.loader = {
  systemd-boot.enable = true;
  efi.canTouchEfiVariables = true;
};

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Amsterdam";
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
    keyMap = "us";
  };

  sound.enable = false;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.pulseaudio.enable = false;
  services.xserver.libinput.enable = true;
  services.blueman.enable = true;
  users.extraUsers.ronard = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };
#home-manager.users.ronard =  {
#     home.stateVersion = "23.11";
#     home.enableNixpkgsReleaseCheck = false;
#gtk = {
#      enable = true;
#      theme = {
#        name = "Catppuccin-Mocha-Standard-Mauve-dark";
#      };
#      iconTheme = {
#        name = "ePapirus-Dark";
#      };
#      cursorTheme = {
#        name = "Capitaine Cursor";
#};
#};
#};
#systemd.services.home-manager-ronard.preStart = ''
#      ${pkgs.nix}/bin/nix-env -i -E 
#'';
programs = {
   hyprland = {
   enable = true;
   xwayland.enable=true;
  };
  fish = {
  enable = true;
  };
};
security = {
rtkit.enable = true ;
};
services = {
pipewire = {
  alsa.support32Bit = true;
  alsa.enable = true;
  enable = true;
  pulse.enable = true;
};
};
environment = {
variables.XCURSOR_SIZE = "24";
  systemPackages = with pkgs; [
    neovim 
    wget
    hyprland
    kitty
    starship
    fish
    git
    rofi-wayland
    waybar
    firefox
    cinnamon.nemo
    mako
    wl-clipboard
    slurp 
    grim
    hyprpaper
    neofetch
    eza    
    home-manager
    telegram-desktop
    pulseaudio
    brightnessctl
    ncdu
    mpv
    spotify
    libreoffice    
    discord
    gcc13
    afetch
    element-desktop
    vscode
    polkit_gnome
  ];
};

  system.stateVersion = "23.11"; # Did you read the comment?

}

