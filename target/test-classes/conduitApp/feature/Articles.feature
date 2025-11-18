
Feature: Articles

    Background: Define URL
        Given url apiUrl

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
        And request {"article": {"taglist": [],"title": "Teste com Karate 22","description": "teste karate","body": "body"}}
        When method Post
        Then status 201
        And response.article.title == 'Teste com Karate 22'
    
    Scenario: Criar e Deletar artigo criado
        And path 'articles'
        And request {"article": {"taglist": [],"title": "Delete Article","description": "Artigo a ser deletado","body": "body"}}
        When method Post
        Then status 201
        * def articleid = response.article.slug

        Given path 'articles'
        Given params { limit: 10, offset:0}
        When method Get
        Then status 200
        And match response.articles[0].title == 'Delete Article'

        Given path 'articles',articleid
        When method Delete
        Then status 204

        Given params { limit: 10, offset:0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'Delete Article'