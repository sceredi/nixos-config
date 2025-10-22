{pkgs, ...}: {
  home.packages = [pkgs.git pkgs.diff-so-fancy];
  programs.git = {
    enable = true;
    signing = {
      key = "3F2E5DD6B8564CAAEFB75B214F363989CBECC6BC";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "sceredi";
        email = "ceredi.simone.iti@gmail.com";
      };
      init.defaultBranch = "main";
      commit.gpgsign = true;
      pull = {
        default = "current";
        rebase = true;
      };

      push = {
        autoSetupRemote = true;
        default = "current";
        followTags = true;
      };

      rebase = {
        autoStash = true;
        missingCommitsCheck = "warn";
      };

      core = {
        compression = 9;
        whitespace = "error";
        preloadindex = true;
      };

      status = {
        branch = true;
        showStash = true;
        showUntrackedFiles = true;
      };

      diff = {
        context = 3;
        renames = "copies";
        interHunkContext = 10;
      };

      log = {
        abbrevCommit = true; # short commits
        graphColors = "blue,yellow,cyan,magenta,green,red";
      };

      pager = {
        diff = "diff-so-fancy | less";
      };

      diff-so-fancy = {
        markEmptyLines = false;
      };

      interactive = {
        diffFilter = "diff-so-fancy --patch";
        singlekey = true;
      };

      branch = {
        sort = "-committerdate";
      };

      tag = {
        sort = "-taggerdate";
      };

      color = {
        "branch" = {
          current = "magenta";
          local = "default";
          remote = "yellow";
          upstream = "green";
          plain = "blue";
        };
        "diff" = {
          meta = "black bold";
          frag = "magenta";
          context = "white";
          whitespace = "yellow reverse";
          old = "red";
        };
        decorate = {
          HEAD = "red";
          branch = "blue";
          tag = "yellow";
          remoteBranch = "magenta";
        };
      };
    };
  };
}
