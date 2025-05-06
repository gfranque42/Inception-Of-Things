all:
	vagrant up

fclean:
	vagrant destroy -f
	rm -rf .vagrant

re: fclean all

stat:
	vagrant status

.PHONY: fclean re all stat