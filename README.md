# Cloud Api

---

## Objetivo    
    Este é um projeto que tem como objetivo estudos de melhores práticas de como
    subir um projeto na AWS usando as melhores práticas para desenvolvimento cloud,
    como terraform e serviço de gerenciamento de containers(ECS).

## requerimentos
    Java 21
    Mysql 8
    Maven
    Docker(opcional)

## Funcionalidades
    Por se tratar de um projeto apenas com objetivo de construir uma pipeline e 
    fazer deploy na AWS, esse projeto não tem nenhuma funcionalidade relevante

## Setup
    Para rodar o projeto é necessário uma conexão com o banco de dados Mysql 8.
    No projeto existe um arquivo de nome docker-compose yml [e possivel usar o comando
    docker-compose up -d para subir o Mysql no container docker.
    
    Com o banco de dados no localhost poderá executar o comando mvn clean install
    para gerar o jar do projeto na pasta target, então rodar o comando java -jar [nome do projeto]

## Objetivo
    O objetivo é colocar esse projeto em execução em um cluser ECS Fargate na AWS
    aplicando segurança, auto escalabilidade, deploy automatizado e esteira CI/CD.

## Palavras chaves
    * ECS
    * Fargate
    * Terraform
    * Git actions
    * Docker
    * java
    * Spring
    * DynamoDB
