package conduitApp.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._
import scala.language.postfixOps

import conduitApp.performance.createTokens.CreateTokens

class PerfTest extends Simulation {

  CreateTokens.createAcessTokens()

  val protocol = karateProtocol(
    "/api/articles/{articleid}" -> Nil
  )

//  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
//  protocol.runner.karateEnv("perf")

//  Esse "feeder" serve para alimentar o script com dados via arquivos csv

//  No gatling 4.0 preciso definir o caminha completo por aqui e não no pom.xml
//  Por padrão ele utiliza a estratégia de fila (queue) que vai no coluna mas se tiver 4 usuários simuntâneos e a coluna tem apenas 3 o teste falha
  val csvFeeder = csv("conduitApp/performance/data/articles.csv").circular

//  Peguei esse metodo da documentation do Gatling
  val tokenFeeder = Iterator.continually(Map("token" -> CreateTokens.getNextToken()))


//  No .feed eu seto a variavel que contém o caminho do arquivo csv que vou usar para alimentar com dados a exexucao do Scenario
//  Posso utilizar mais de um feeder no scenario
  val createArticle = scenario("Criar e Deletar artigo criado")
      .feed(csvFeeder)
      .feed(tokenFeeder)
      .exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))

  setUp(
    createArticle.inject(
//      Injeta apenas um usuário
      atOnceUsers(1),
//      Não faz nada durante 4 segundos
      nothingFor(4 seconds),
//      Injeta 1 usuário por segundos durante 10 segundos
      constantUsersPerSec(1) during (3 seconds),
//      Injeta 2 usuário por segundos durante 10 segundos
//      constantUsersPerSec(2) during (10 seconds),
//      Aumenta gradualmente a quantidade de usuários começando com 2 usuários até 10 durando um tempo de 20 segundos
//      rampUsersPerSec(2) to 10 during (20 seconds),
//      Não faz nada durante 5 segundos
//      nothingFor(5 seconds),
//      Injeta 1 usuário por segundos durante 5 segundos
//      constantUsersPerSec(1) during (5 seconds)
      ).protocols(protocol)
  )

}