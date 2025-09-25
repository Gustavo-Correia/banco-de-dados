# README.md

Este projeto é um sistema de gestão para uma clínica, implementado com Java, Spring Boot e JavaFX, e utiliza um banco de dados SQL Server.
<div style="display: inline_block"><br>
      <img align="center" height="150" width="150" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/java/java-original.svg">
      <img align="center" height="150" width="150" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/docker/docker-original.svg">
      <img align="center" height="150" width="150" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/sqldeveloper/sqldeveloper-original.svg">
      <img align="center" height="150" width="150" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/maven/maven-original.svg">
      <img align="center" height="150" width="150" src="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/spring/spring-original.svg">
</div>

### Tecnologias Utilizadas

* **Java**: Versão 17.
* **Spring Boot**: Framework para desenvolvimento de aplicações Java.
* **JavaFX**: Para a interface gráfica da aplicação.
* **Maven**: Ferramenta de automação de construção para o gerenciamento do projeto e suas dependências.
* **SQL Server**: Sistema de gestão de banco de dados relacional.
* **Docker**: Para a execução do contêiner do SQL Server.

## 📂 Estrutura do Projeto  


```plaintext
├── docker-compose.yml                # Configuração do SQL Server no Docker
├── Atividade_banco_de_dados_1_create.sql  # Script de criação do banco de dados
├── Atividade_banco_de_dados_1_insert.sql # Script dos insertions do banco de dados 
├── pom.xml                           # Configuração Maven
├── mvnw                              # Maven Wrapper (Linux/Mac)
├── mvnw.cmd                          # Maven Wrapper (Windows)
└── src/                              # Código-fonte Java
```
### Configuração do Banco de Dados

1.  **Inicie o contêiner do SQL Server com Docker**:
    Execute o seguinte comando na pasta do projeto:
    ```bash
    docker-compose up -d
    ```

2.  **Conecte-se ao banco de dados**:
    Utilize um cliente SQL Server (SGDB) ou o terminal do Docker com as seguintes credenciais:
    * **Nome do Servidor**: `localhost`
    * **Autenticação**: Autenticação do SQL Server
    * **Logon**: `sa`
    * **Senha**: `SenhaForte123!`

3.  **Crie o banco de dados e as tabelas**:
    Após a conexão, crie o banco de dados e as tabelas executando o script SQL do arquivo `Atividade_banco_de_dados_1_create.sql`.

4.  **Insira os dados iniciais**:
    Popule as tabelas com dados de exemplo executando o script SQL do arquivo `Atividade_banco_de_dados_1_insert.sql`.

### Execução da Aplicação

1.  **Compile e execute o projeto Maven**:
    Para a primeira execução do projeto , executo o comando na pasta raiz do projeto:
    ```bash
    ./mvnw -v
    ```
    Na pasta raiz do projeto, execute o seguinte comando para compilar e iniciar a aplicação:
    ```bash
    ./mvnw clean compile exec:java
    ```
3.  **Atenção**: Certifique-se de que o banco de dados esteja em execução via Docker antes de iniciar a aplicação. As configurações de conexão estão definidas no arquivo `Conexao.java`.

### Descrição dos Arquivos SQL

* `Atividade_banco_de_dados_1_create.sql`: Script para criar o banco de dados `ClinicaDB` e todas as tabelas (Paciente, Medicos, Sala, Consulta, etc.) com suas respectivas chaves primárias e estrangeiras.
* `Atividade_banco_de_dados_1_insert.sql`: Script que contém comandos `INSERT` para popular as tabelas com dados de teste e várias consultas `SELECT` de exemplo.


## 👥 Equipe  

Este projeto foi desenvolvido por:  
- 👨‍💻 [**Gabriel Silveira Fraga**](https://github.com/Gabr1elFraga)
- 👨‍💻 [**Hiakewve Santos Alves**](https://github.com/Hiakewve)
- 👨‍💻 [**Luís Gustavo Alves Correia**](https://github.com/Gustavo-Correia)
- 👨‍💻 [**Miguel Menezes Andrade**](https://github.com/Zerxf-exe)
- 👨‍💻 [**Jose Valter Santos de Jesus**](https://github.com/TheOne-z1)

### 👨‍🏫 Professor Orientador  
- 🏫 **José Vinícius de Carvalho Oliveira**


