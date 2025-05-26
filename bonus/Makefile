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
	@echo "waiting for setup"
	@sleep 120
	@echo "setup done"
	@./gitlabsetup.sh
dockerdown:
	docker compose stop
	docker compose down

.PHONY: fclean re all stat uninstall install
