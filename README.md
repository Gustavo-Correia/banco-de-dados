na pasta do projeto de
docker-compose up -d ou docker compose up

conexao pelo terminal do docker
sqlcmd -S localhost -U sa -P SenhaForte123!

conexao pelo sgdb do sql server

Nome do servidor:localhost
Autenticação: escolhe do sql server
logon:sa
senha:SenhaForte123!


apos entrar no sgdb ou no terminal do docker crie a database com auxilio do arquivo
Atividade_banco_de_dados_1_create.sql

Maven
./mvnw -v

compilar
./mvnw clean compile exec:java