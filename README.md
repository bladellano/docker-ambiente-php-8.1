# Base para Drupal 8/9

Base para desenvolvimento Drupal 8/9 ou também para desenvolver qualquer aplicação com PHP 8.1 + MySQL + PhpMyAdmin

# Instalação
### Pré requisitos: Docker e Docker Compose

```bash
#Clonar repositótio
git clone https://github.com/bladellano/docker-ambiente-php-7.git

# Caso queira manter o container persistindo. Para encerrar `CTRL + C`
docker-compose up

# Criar e levantar os containers
docker-compose up -d

# Iniciar o container Docker
docker-compose start

# Parar o container Docker
docker-compose stop

# Parar e remover containers da máquina
docker-compose down
```

# Como instalar Drupal 9
Após criar com sucesso o containers, procure a pasta `www` aonde será armazenado os projetos em php. Em um terminal dentro da pasta `www`, faça:
```bash
$ composer create-project --no-install drupal/recommended-project drupal9
```
- Após baixar o projeto Drupal, faça:
```bash
$ composer install --ignore-platform-reqs
```
### Criar a base para o Drupal. Acesse o PhpMyAdmin `http://localhost:4520`
```bash
User: root
Password: root
```
 - Em seguida, clicando em `novo`, crie uma base com qualquer nome. Exemplo: `drupal9`.
### Acessando a área das aplicações - www:
- Url: `http://localhost:4500`

### Acessando o banco por um outro SGBD
- Configure o host desta forma:
```bash
Host: localhost
Port: 4510
User: root
Password: root
```
### Permissão de escrita nas pastas do Drupal
```bash
$ cd www/drupal/web/sites/ 
$ sudo chmod 777 -R default/
$ cd /default
$ cp default.settings.php settings.php
$ sudo chmod 777 settings.php
#Depois de concluir a instalação com sucesso
$ sudo chmod 755 -R default/ 

#Quando for instalar um theme
$ sudo chown www-data -R web/themes/
$ sudo chown www-data -R web/sites/

#Ou tudo isso, por isso:
$ cd web
$ sudo chown www-data:www-data sites -R

#Drush
$ composer require --dev drush/drush 

#Importando DATABASE
$ cd drupal/
$ mkdir drupal/db #Copiar p/ este local o dump.sql
$ ./vendor/bin/drush sqlc < ./db/drupal9x.sql
```
### Habilitar listagem de pasta no Apache
```bash
$ vim /etc/apache2/apache2.conf
#Adicionar
<Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
</Directory>
```
### Make
```bash
make install: #Apaga todos os containers e reconstroi
make in: # Entrar no bash do php-apache-php-8.1
make up: # Levanta os containers 
make stop: #Para os containers
```

### No Drupal ao finalizar a configuração do banco, em host utilize `db-local`, o resto tudo igual a configuração acima.

**Referências**
1. [Imagem - webdevops/php-apache](https://dockerfile.readthedocs.io/en/latest/content/DockerImages/dockerfiles/php-apache.html)
2. [Imagem - MySQL](https://hub.docker.com/_/mysql)
3. [Imagem - phpMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/)
3. [Como instalar - Docker e Docker Compose](#) 