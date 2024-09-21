{ config, lib, pkgs, ... }: {
  services = {
    # Network shares
    samba = {
      package = pkgs.samba;
      # ^^ `samba4Full` is compiled with avahi, ldap, AD etc support (compared to the default package, `samba`
      # Required for samba to register mDNS records for auto discovery 
      # See https://github.com/NixOS/nixpkgs/blob/592047fc9e4f7b74a4dc85d1b9f5243dfe4899e3/pkgs/top-level/all-packages.nix#L27268
      enable = true;
      openFirewall = true;
      shares.testshare = {
        path = "/home/simone/Public/";
        writable = "true";
        comment = "Hello World!";
      };
      # extraConfig = ''
      #   server smb encrypt = required
      #   # ^^ Note: Breaks `smbclient -L <ip/host> -U%` by default, might require the client to set `client min protocol`?
      #   server min protocol = SMB3_00
      # '';
    };
  };
}
