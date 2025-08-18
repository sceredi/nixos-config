HOSTNAME = $(shell hostname)

NIX_FILES = $(shell find . -name '*.nix' -type f)

ifndef HOSTNAME
 $(error Hostname unknown)
endif

switch:
	nixos-rebuild switch --sudo --flake .#${HOSTNAME} -L

boot:
	nixos-rebuild boot --sudo --flake .#${HOSTNAME} -L

test:
	nixos-rebuild test --sudo --flake .#${HOSTNAME} -L --show-trace

update:
	nix flake update

upgrade:
	make update && make switch

neovim:
	nix flake update sceredi-nix-cats && make switch

