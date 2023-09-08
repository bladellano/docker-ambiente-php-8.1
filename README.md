# Base para Drupal 8|9|10

Base para desenvolvimento Drupal ou também para desenvolver qualquer aplicação com:
- PHP 8.1 
- MySQL 
- PhpMyAdmin

## Pré requisitos:
- Docker
- Docker Compose

# Repositório:

```bash
#Clonar repositótio
git clone https://github.com/bladellano/docker-ambiente-php-7.git
```
# Levantando ambiente:
### Comandos Make
```bash
make install: # Apaga todos os containers e reconstroi
make in: # Entrar no bash do php-apache-php-8.1
make up: # Levanta os containers 
make stop: # Pára os containers
```
# Como instalar Drupal 9:
Após criar com sucesso o containers, procure a pasta `www` aonde será armazenado os projetos em php. Em um terminal dentro da pasta `www`, faça (mas não dentro dos containers, no seu ambiente local mesmo):
```bash
$ composer create-project --no-install drupal/recommended-project:9.5.3 drupal9-00
```
Após baixar o projeto Drupal, faça. O comando abaixo ignora a versão do seu php local e instala todas dependências:
```bash
cd drupal9
composer install --ignore-platform-reqs
```
### Criar a base para o Drupal. Acesse o PhpMyAdmin [http://localhost:4520](http://localhost:4520)
```bash
User: root
Password: root
```
Em seguida, clicando em `NOVO`, crie uma base com qualquer nome. Por exemplo: `drupal9_00`
### Agora acessando a área das projetos `www`:
Link: [http://localhost:4500](http://localhost:4500)

### Caso queira acessar o banco por um outro SGBD, faça:
Configure o host desta forma:
```bash
Host: 127.0.0.1
Port: 4510
User: root
Password: root
#No Drupal durante a configuração/instalação do banco, em host utilize `db-local`, o resto tudo igual a configuração acima.
```

### Durante a instalação do Drupal
Permissão de escrita nas pastas:
```bash
mkdir /web/sites/default/ → files/translations
chmod 777 -R /files/translations

cp web/sites/default/default.settings.php web/sites/default/settings.php
sudo chmod 777 web/sites/default/settings.php

# Depois de concluir a instalação com sucesso, faça:
chmod 444 settings.php

####################################
###QUANDO FOR CRIAR CUSTOM THEMES###
####################################
sudo chown www-data -R web/themes/
sudo chown www-data -R web/sites/

# Ou tudo isso, por isso:
cd web
sudo chown www-data:www-data sites -R

# Drush - Importante!
composer require --dev drush/drush 

# Importando uma base dados (apenas dica/sugestão):
cd drupal/
mkdir drupal/db-init # Copiar para este local o dump.sql
./vendor/bin/drush sqlc < ./db-init/backup.sql
```
### Habilitar listagem de pasta no apache do container
```bash
nano /etc/apache2/apache2.conf
#Adicionar

<Directory /var/www/html>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
</Directory>
```
**Referências**
1. [Imagem - webdevops/php-apache](https://dockerfile.readthedocs.io/en/latest/content/DockerImages/dockerfiles/php-apache.html)
2. [Imagem - MySQL](https://hub.docker.com/_/mysql)
3. [Imagem - phpMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/)
3. [Como instalar - Docker e Docker Compose](#) 