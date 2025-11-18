//Função que peguei da documentação do karate e modifiquei. Serve para validar o campo onde retorna a data se está retornando corretamente
function fn(s) {
    var SimpleDateFormat = Java.type("java.text.SimpleDateFormat");
    var sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.ms'Z'");
    try {
        sdf.parse(s).time;
        return true;
    }   catch(e) {
        karate.log('*** data string invalida:', s);
        return false;
    }
}