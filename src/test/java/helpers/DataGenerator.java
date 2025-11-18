package helpers;

import com.github.javafaker.Faker;

public class DataGenerator {
    
    public static String GetRandomEmail(){
        Faker faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0,100) + "@test.com";
        return email;
    }

    public static String GetRandomUsername(){
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

    //Exemplo do método GetRandomUsername sendo instanciado, ou seja não sendo Static
    public String GetRandomInstanciado(){
        Faker faker = new Faker();
        String username = faker.name().username();
        return username;
    }

}
