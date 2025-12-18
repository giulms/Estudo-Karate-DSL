
Feature: Articles

  Background: Define URL
    * url apiUrl
    * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def datagenerator = Java.type('helpers.DataGenerator')
    * set articleRequestBody.article.title = datagenerator.GetRandomArticleValues().title
    * set articleRequestBody.article.description = datagenerator.GetRandomArticleValues().description
    * set articleRequestBody.article.body = datagenerator.GetRandomArticleValues().body

  Scenario: Criar e Deletar artigo criado
    And path 'articles'
    And request articleRequestBody
    When method Post
    Then status 201
    * def articleid = response.article.slug

#   Posso usar o karate.pause direto na nova atualização do Karate
    * karate.pause(5000)

    Given path 'articles',articleid
    When method Delete
    Then status 204