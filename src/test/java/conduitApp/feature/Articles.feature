
Feature: Articles

    Background: Define URL
        # aqui seto o URL
        * url apiUrl
        # aqui importo o payload que vou utilizar para dar o post
        * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
        # aquio chamo a classe Datagenerator, onde estou criando dados fakes
        * def datagenerator = Java.type('helpers.DataGenerator')

        # aqui seto os valores do payload com os dados fakes que criei na classe java
        * set articleRequestBody.article.title = datagenerator.GetRandomArticleValues().title
        * set articleRequestBody.article.description = datagenerator.GetRandomArticleValues().description
        * set articleRequestBody.article.body = datagenerator.GetRandomArticleValues().body

        # Posso utilizar dessa forma também como Backgoud, porém também posso puxar da pasta helpers a criação do token
        # Given path 'users/login'
        # And request {"user": {"email": "karatezada@gmail.com","password": "karate123"}}
        # When method Post
        # Then status 200
        # * def token = response.user.token

        # Com o 'call' ele vai executar todas as vezes que rodar o cenário, já com o 'callonce' ele executa apenas uma vez
        # Posso setar como argumento assim: {"email": "karatezada@gmail.com","senha": "karate123"}

    Scenario: Criar novo artigo
        Given path 'articles'
        And request articleRequestBody
        When method Post
        Then status 201
        And response.article.title == articleRequestBody.article.title
    
    Scenario: Criar e Deletar artigo criado
        And path 'articles'
        And request articleRequestBody
        When method Post
        Then status 201
        * def articleid = response.article.slug

        Given path 'articles'
        Given params { limit: 10, offset:0}
        When method Get
        Then status 200
        And match response.articles[0].title == articleRequestBody.article.title

        Given path 'articles',articleid
        When method Delete
        Then status 204

        Given params { limit: 10, offset:0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != articleRequestBody.article.title