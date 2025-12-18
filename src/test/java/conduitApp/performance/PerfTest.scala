package conduitApp.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._

class PerfTest extends Simulation {

  val protocol = karateProtocol(
    "/api/articles/{articleid}" -> Nil
  )

//  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
//  protocol.runner.karateEnv("perf")

  val createArticle = scenario("Criar e Deletar artigo criado").exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))

  setUp(
    createArticle.inject(
//      Injeta apenas um usuário
      atOnceUsers(1),
//      Não faz nada durante 4 segundos
      nothingFor(4 seconds),
//      Injeta 1 usuário por segundos durante 10 segundos
      constantUsersPerSec(1) during (10 seconds),
//      Injeta 2 usuário por segundos durante 10 segundos
      constantUsersPerSec(2) during (10 seconds),
//      Aumenta gradualmente a quantidade de usuários começando com 2 usuários até 10 durando um tempo de 20 segundos
      rampUsersPerSec(2) to 10 during (20 seconds),
//      Não faz nada durante 5 segundos
      nothingFor(5 seconds),
//      Injeta 1 usuário por segundos durante 5 segundos
      constantUsersPerSec(1) during (5 seconds)
      ).protocols(protocol)
  )

}