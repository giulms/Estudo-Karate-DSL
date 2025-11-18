
Feature: Criar Token

    Scenario: Criar Token
        Given url apiUrl
        Given path 'users/login'
        And request {"user": {"email": "#(userEmail)","password": "#(userSenha)"}} //utilizo o '#()' para ficar como parametros, setando ela na chamada do cenario
        When method Post
        Then status 200
        * def authToken = response.user.token