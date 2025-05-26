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

dockerup:
	docker compose up --build -d
	sleep 120
	docker exec -it gitlab cat /etc/gitlab/initial_root_password

dockerdown:
	docker compose stop
	docker compose down

.PHONY: fclean re all stat uninstall install
