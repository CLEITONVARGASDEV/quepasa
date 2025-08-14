# This his how to install QuePasa with docker

1 - Import the project to a folder

2 - Copy the env.example file to .env:
   ```bash
   cp env.example .env
   ```

3 - Edit the ``.env`` with your settings

4 - run the command `docker-compose up -d --build`

# Como instalar o QuePasa com docker

1 - Importe o projeto para uma pasta

2 - Copie o arquivo env.example para .env:
   ```bash
   cp env.example .env
   ```

3 - Edite o ``.env`` com suas configurações

4 - Faça esta sequência de comandos:
```
docker-compose build
docker-compose up -d
```
ou 
```
docker compose build
docker compose up -d
```
ou 
```
docker-compose up -d --build
```

# Corrigir erro de banco de dados sqlite

docker exec -it $(basename $(pwd))_rails_1 sh -c 'RAILS_ENV=production bundle exec rails c'
