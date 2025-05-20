all:
	sudo sh setup.sh

fclean:
	sudo k3d cluster delete --all
	sudo docker volume prune
	sudo docker system prune -af

re: fclean all

install:
	sudo sh install.sh

uninstall:
	sudo sh uninstall.sh

.PHONY: fclean re all stat uninstall install
