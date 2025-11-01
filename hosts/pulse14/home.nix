{
  home-manager.users.simone = {
    programs.git = {
      signing = {
        key = "3F2E5DD6B8564CAAEFB75B214F363989CBECC6BC";
        signByDefault = true;
      };
      settings.commit.gpgsign = true;
    };
  };
}
