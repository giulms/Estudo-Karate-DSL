
Feature: Hooks

    Background: hooks
#        * def result = callonce read('classpath:helpers/Dummy.feature')
#        * def username = result.username

      #After Hooks

      #O afterScenario executa após cada cenário, no log printa apenas o username que chama no classpath do Dummy pois o username aqui de cima está comentado
      * configure afterScenario = function(){ karate.call('classpath:helpers/Dummy.feature') }

      #O afterFeature executa após a feature completar, ele printa no log essa mensagem logo após o final da feature
      * configure afterFeature =
      """
          function (){
              karate.log('Texto com After Feature')
          }
      """

    Scenario: Primeiro Cenario
        * print username
        * print 'Esse é o primeiro cenario'

    Scenario: Segundo Cenario
        * print username
        * print 'Esse é o segundo cenario'