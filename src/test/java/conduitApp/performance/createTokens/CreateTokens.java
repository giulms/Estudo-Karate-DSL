package conduitApp.performance.createTokens;

import com.intuit.karate.Runner;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

public class CreateTokens {

    private static final ArrayList<String> tokens = new ArrayList<>();
    private static final AtomicInteger counter = new AtomicInteger();

    private static String[] emails = {
            "karatedemo1@test.com",
            "karatedemo2@test.com",
            "karatedemo3@test.com"
    };

//    Esse metodo retorna o proximo token de forma rotativa, ou seja sempre vai o proximo da fila
    public static String getNextToken() {
        return tokens.get(counter.getAndIncrement() % tokens.size());
    }


    public static void createAcessTokens(){

//        Primeiro faço um loop para percorrer os emails do array de cima
        for(String email : emails){
//            Cria um array chamado account do tipo chave valor ou seja "chave":"valor"
            Map<String, Object> account = new HashMap<>();
//            Coloca o email dentro do array
            account.put("userEmail", email);
            account.put("userPassword", "Welcome1");
//            Cria um array chamado result do tipo chave valor que armazena o resultado da feature "CreateToken"
            Map<String, Object> result = Runner.runFeature("classpath:helpers/CreateToken.feature",account,true);
//            Pega o valor authToken do array result e tranforma em String para aramazenar no array "tokens"
            tokens.add(result.get("authToken").toString());
        }
    }
}
