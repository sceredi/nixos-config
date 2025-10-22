{
  home-manager.users.simone = {pkgs, ...}: {
    home.packages = with pkgs; [
      uv
      (python3.withPackages (
        ps:
          with ps; [
            black
            pyflakes
            isort
            pipenv
            setuptools
            pytest
            sdl3
          ]
      ))
    ];
  };
}
