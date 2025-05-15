all:
	sudo sh setup.sh

fclean:
	sudo k3d cluster delete --all

re: fclean all

install:
	sudo sh install.sh

uninstall:
	sudo sh uninstall.sh

.PHONY: fclean re all stat uninstall install
