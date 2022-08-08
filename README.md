# Base para Drupal 8

Base para desenvolvimento Drupal 8 ou também para desenvolver qualquer aplicação com PHP 7.2.27 + MySQL + PhpMyAdmin

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

# Como instalar Drupal 8
- Por enquanto estou usando esta versão de projeto Drupal. Após criar com sucesso o container, procure a pasta `www` aonde será armazenado os projetos em php. Em um terminal dentro da pasta `www`, faça:
```bash
> composer create-project --no-install drupal-composer/drupal-project:8.x-dev --stability dev --no-interaction drupal8
```
- Após baixar o projeto Drupal, faça:
```bash
> composer install --ignore-platform-reqs
```
### Criar a base para o Drupal. Acesse o PhpMyAdmin `http://localhost:8080`
```bash
User: root
Password: root
```
 - Em seguida, clicando em `novo`, crie uma base com qualquer nome. Exemplo: `drupal8`.
### Acessando a área das aplicações - www:
- Url: `http://localhost:4500`

### Acessando o banco por um outro SGBD
- Configure o host desta forma:
```bash
Host: localhost
Port: 8004
User: root
Password: root
```

### No Drupal ao finalizar a configuração do banco, em host utilize `db-local`, o resto tudo igual a configuração acima.

**Referências**
1. [Imagem - webdevops/php-apache](https://dockerfile.readthedocs.io/en/latest/content/DockerImages/dockerfiles/php-apache.html)
2. [Imagem - MySQL](https://hub.docker.com/_/mysql)
3. [Imagem - phpMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/)
3. [Como instalar - Docker e Docker Compose](#) 