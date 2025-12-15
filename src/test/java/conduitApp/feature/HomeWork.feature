
Feature: Atividade

    Background: Precondicoes
        * url apiUrl

    Scenario: Favoritar Artigo
        * def timeValidator = read('classpath:helpers/timeValidator.js')

        Given path 'articles'
        Given params { limit: 10, offset:0}
        When method Get
        Then status 200

        * def slugID = response.articles[0].slug
        * def favoritesCount = response.articles[0].slug

        Given path 'articles',slugID,'favorite'
        And request {}
        When method Post
        Then status 200
        And match response.article.slug == slugID
        And match response.article.favoritesCount == 1
        And match response.article.favorited == true

        Given path 'articles'
        Given params { limit: 10, offset:0}
        When method Get
        Then status 200
        And match each response.articles ==
        """
            {
                  "slug": "#string",
                  "title": "#string",
                  "description": "#string",
                  "body": "#string",
                  "tagList": "#array",
                  "createdAt": "#? timeValidator(_)",
                  "updatedAt": "#? timeValidator(_)",
                  "favorited": "#boolean",
                  "favoritesCount": "#number",
                  "author": {
                    "username": "#string",
                    "bio": "##string",
                    "image": "#string",
                    "following": "#boolean"
                  }
            }
        """
        And match response.articles[0].favoritesCount == 1
        And match response.articles[*].slug contains slugID

    Scenario:  Conditional logic
      Given path 'articles'
      Given params { limit: 10, offset:0}
      When method Get
      Then status 200
      * def favoritesCount = response.articles[0].favoritesCount
      * def article = response.articles[0]

#      Forma mais simples de fazer uma condicional IF (IF simples)
#      * if (favoritesCount == 0) karate.call('classpath:helpers/addLikes.feature', article)

#      Essa é uma outra forma de usar uma condicional IF (IF Else, a "?" separa a condição do valor se verdadeiro)
#      É isso que está acontecendo aqui ->  condição ? valor_se_verdadeiro : valor_se_falso
      * def result = favoritesCount == 0 ? karate.call('classpath:helpers/addLikes.feature', article).likesCount : favoritesCount
#      Ele também chama a feature addLikes com o argumento article se o valor for 0. E pega o likes.Count e seta como valor da variável "result"

      Given params { limit: 10, offset:0}
      Given path 'articles'
      When method Get
      Then status 200
      And match response.articles[0].favoritesCount == result

    Scenario:  Retry call
#      Estou configurando a keyword "retry" para o número de tentativas se 10 e o intervalo entre elas ser 5 segundos
      * configure retry = { count: 10, interval:5000 }

      Given path 'articles'
      Given params { limit: 10, offset:0}
#      Estou fazendo ele utilizar o retry até a condição -> favoritesCount ser 1
      And retry until response.articles[0].favoritesCount == 1
      When method Get
      Then status 200

    Scenario: Sleep call
#      Aqui estou setando a funcao sleep para ele esperar um determinado tempo antes de fazer algo (peguei a funcao do repo do karate)
      * def sleep = function(pause){ java.lang.Thread.sleep(pause) }

      Given path 'articles'
      Given params { limit: 10, offset:0}
      When method Get
#      Quando digito "eval" ele apenas chama a funcao que eu quero mas nao armazena, diferente do def que chama e armazena
      * eval sleep(5000)
      Then status 200