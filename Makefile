# Automatizando comandos

install:
	docker-compose down
	docker-compose up -d --build

in:
	docker exec -it php-apache-php-8.1 bash

up: 
	docker-compose up -d 
	
stop:
	docker-compose stop