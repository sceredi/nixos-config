HOSTNAME = $(shell hostname)

NIX_FILES = $(shell find . -name '*.nix' -type f)

ifndef HOSTNAME
 $(error Hostname unknown)
endif

switch:
	nixos-rebuild switch --use-remote-sudo --flake .#${HOSTNAME} -L --impure

boot:
	nixos-rebuild boot --use-remote-sudo --flake .#${HOSTNAME} -L --impure

test:
	nixos-rebuild test --use-remote-sudo --flake .#${HOSTNAME} -L --show-trace --impure

update:
	nix flake update

upgrade:
	make update && make switch

neovim:
	nix flake lock --update-info nixvim && make switch

