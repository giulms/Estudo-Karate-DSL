
Feature: Cadastrar Novo usuário

    Background: Precondicoes
        * def datagenerator = Java.type('helpers.DataGenerator') //aqui estou dando um import na classe que criei para gerar email e username aleatórios
        * def randomEmail = datagenerator.GetRandomEmail() // aqui estou puxando os métodos de geração de dados com o faker que fiz num arquivo java
        * def randomUsername = datagenerator.GetRandomUsername()
        Given url apiUrl
    
    Scenario: Cadastrar novo usuario

        ####################################################################################
        # Demonstração de como posso utilizar se o método java não for stastic
        # * def jsFunction = 
        # """
        #     Function () {
        #         var Datagenerator = Java.type('helpers.DataGenerator')
        #         var generator = new DataGenerator()
        #         return generator.GetRandomInstanciado()
        #     }
        # """
        # * def randomUsernameInstanciado = call jsFunction
        ####################################################################################

        Given path 'users'
        # o print da um console.log na variavel escolhida
        * print randomEmail
        And request 
        """
        {
            "user": {
                "email": #(randomEmail), 
                "password": "karate321", 
                "username": #(randomUsername)
            }
        }
        """
        When method Post
        Then status 201
        And match response == 
        """
        {
            "user": {
                "id": "#number",
                "email": #(randomEmail),
                "username": #(randomUsername),
                "bio": "##boolean",
                "image": "#string",
                "token": "#string"
            }
        }
        """

    #Exemplo de Scenario com Data Driven Test
    Scenario Outline: Validar mensagem de erro no cadastro

        Given path 'users'
        And request 
        """
        {
            "user": {
                "email": "<email>", 
                "password": "<password>", 
                "username": "<username>"
            }
        }
        """
        When method Post
        Then status 422
        And match response == <errorResponse>

        Examples:
            | email                | password  | username          | errorResponse                                        |
            | #(randomEmail)       | Karate123 | NovoKarate        | {"errors": {"username": ["has already been taken"]}} |
            | karatezada@gmail.com | Karate123 | #(randomUsername) | {"errors": {"email": ["has already been taken"]}}    |
            | karatezada@gmail.com |           | #(randomUsername) | {"errors": {"password": ["can't be blank"]}}         |
            #Posso colocar vários exemplos para testar todas as possibilidades
    