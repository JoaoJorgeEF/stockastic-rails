# Stockastic-Rails

Comandos necessários para rodar a aplicação.

## Pré-requisitos:
* [Ruby](https://www.ruby-lang.org/pt/downloads/)
* [Ruby on Rails](https://guides.rubyonrails.org/getting_started.html)

## Configuração:

* Primeiro será necessário rodar o seguinte comando no diretório do projeto:

```
bundle install
```

* Em seguida, para inicializar o projeto, basta rodar:

```
rails server
```

## Utilização

Inicialmente, `Stockastic-Rails` é uma API utilizada para autenticação do Front `Stockastic-Front`, para tal, ela fornece alguns endpoints para signup de usuário, login e logout, [aqui você pode encontrar uma Collection Postman com a documentação de todos esses endpoints](https://github.com/JoaoJorgeEF/stockastic-rails/blob/main/Stockastic%20Rails.postman_collection.json), basta fazer o download e abrir com o aplicativo do Postman:

### POST Signup:

<img src="readme-images\Signup.png"/>

### POST Login:

<img src="readme-images\Login.png"/>

A chamada ao endpoint de Login irá gerar nos Headers da resposta, um token de `Authorization`, na seguinte estrutura "Bearer {TOKEN_JWT}"

<img src="readme-images\Token.png"/>

### DELETE Logout:

O Token recebido pelo endpoint de login deverá ser enviado nos Headers do endpoint de Logout para que o usuário consiga finalizar sua sessão com sucesso

<img src="readme-images\TokenLogout.png"/>

<img src="readme-images\Logout.png"/>