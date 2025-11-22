HOSTNAME = $(shell hostname)

NIX_FILES = $(shell find . -name '*.nix' -type f)

ifndef HOSTNAME
 $(error Hostname unknown)
endif

switch:
	nixos-rebuild switch --flake .#${HOSTNAME} -L

rollback:
	nixos-rebuild switch --flake .#${HOSTNAME} -L --rollback

boot:
	nixos-rebuild boot --flake .#${HOSTNAME} -L

test:
	nixos-rebuild test --flake .#${HOSTNAME} -L --show-trace

update:
	nix flake update

upgrade:
	make update && make switch

neovim:
	nix flake update sceredi-nix-cats && make switch

