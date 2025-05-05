{
  home-manager.users.simone = {pkgs, ...}: {
    home.packages = with pkgs; [
      (python3.withPackages (
        ps:
          with ps; [
            black
            pyflakes
            isort
            pipenv
            setuptools
            pytest
          ]
      ))
    ];
  };
}
