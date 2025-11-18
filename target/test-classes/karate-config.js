function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);

  //por default o padrão fica o ambiente 'dev'
  if (!env) {
    env = 'dev';
  }

  //seto a URL da Api no objeto config
  var config = {
    apiUrl: 'https://conduit-api.bondaracademy.com/api/'
  }

  //seto os ambientes que vou ter e o que quero armazenar em cada um dele
  if (env == 'dev') {
    config.userEmail = 'karatezada@gmail.com'
    config.userSenha = 'karate123'
  } 
  if (env == 'qa') {
    config.userEmail = 'karatezada2@gmail.com'
    config.userSenha = 'karate1234'
  }

  // Crio a variavel 'acessToken' que dentro dela vou estar chamando uma vez durante toda a suite de testes (callSingle) a feature dentro do caminho 'classpath:helpers/CreateToken.feature'
  //onde passo como parametro o objeto config, que dentro dele tem o url, email e senha. E com o '.authToken' vou estar capturando o Token de retorno da chamada
  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})

  return config;
}