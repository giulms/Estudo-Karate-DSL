
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