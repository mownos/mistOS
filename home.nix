{ config, pkgs, lib, ... }:

{
  home.username = "mist";
  home.homeDirectory = "/home/mist";
  home.sessionVariables = {
    all_proxy = "socks://192.168.101.4:6153";
  };
  
#  xdg.configFile.nvim = {
 #   source = /etc/nixos/packages/nvim;
  #  recursive = true;
  #};  
 
  programs.gh.enable = true; 
 
  programs.git = {
    enable = true;
    userName = "Mist";
    userEmail = "mist.zzh@gmail.com";
  };

  programs.neovim = {
    enable = true;
#    extraLuaConfig = lib.fileContents ./packages/nvim/init.lua;
  };

  programs.zsh = {
    enable = true;	

    initExtra = ''
bindkey '\eOB' history-substring-search-down # or ^[OB   
bindkey '\eOA' history-substring-search-up # or ^[OA
 '';

    shellAliases = {
      update_os = "sudo nixos-rebuild switch --show-trace";
      update_os_proxy = "update_os --option substituters https://mirrors.ustc.edu.cn/nix-channels/store";
      os_git = "git --git-dir=$HOME/mistOS/ --work-tree=/etc/nixos";
    };
    
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-history-substring-search"; }
      ];
    };
    
    plugins = [
{
    name = "powerlevel10k";
    src = pkgs.zsh-powerlevel10k;
    file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  }
{
    name = "powerlevel10k-config";
    src = ./theme;
    file = ".p10k.zsh";
  }
 ];
  };

  home.packages = with pkgs; [
    neofetch
    zip
    nix-output-monitor
    lua
  ];
  
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
