
Feature: Tests na página inicial

    Background: Define URL
        Given url apiUrl  //seta a variável de URL base
    
    Scenario: Get todas as tags
        Given path 'tags'   //adiciona uma nova variação para o endpoint
        When method Get
        Then status 200
        
        And match response.tags == '#array'
        And match each response.tags == '#string'
    
    Scenario: Get 10 articles da página inicial
        * def timeValidator = read('classpath:helpers/timeValidator.js')

        Given path 'articles'
        Given params {  limit: 10, offset: 0 }  //adiciona parâmetros de consulta no endpoint
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response == {"articles": "#array", "articlesCount": 18}
        And match response.articles[0].favorited == false
        And match response.articles[0].createdAt contains '2025'
        And match response.articles[*].favoritesCount contains 401
        And match response..bio contains null //posso usar assim também pra não ficar muito longo, ele já puxa todos os articles como está no exemplo acima
        And match each response..following == false //quando é um valor boolean é necessário colocar each antes e quando é array não precisa
        And match each response.articles == 
        #verifico se a estrutura do payload está retornando com os elementos da forma correta Ex: O que é array está retornando array?
        #esse time validator copiei da documentação do karate e modifiquei conforme necessito
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
