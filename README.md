# 🥋 Karate DSL - Estudo & Automação de Testes

![Karate](https://img.shields.io/badge/Karate-1.5.0-orange?style=for-the-badge)
![Java](https://img.shields.io/badge/Java-21-blue?style=for-the-badge&logo=openjdk)
![Maven](https://img.shields.io/badge/Maven-3.8+-red?style=for-the-badge&logo=apachemaven)

Projeto de estudos para automação de testes de API utilizando **Karate DSL**, framework poderoso que combina testes de API, mocks e performance em uma única ferramenta.

---

## 📚 Sobre o Projeto

Este repositório contém exemplos práticos e exercícios do curso de **Karate DSL da Udemy**, implementando testes automatizados para a API do [Conduit](https://conduit-api.bondaracademy.com/).

### ✨ Funcionalidades Implementadas

- ✅ Testes de autenticação (login/signup)
- ✅ CRUD de artigos
- ✅ Validação de schemas JSON
- ✅ Data Driven Testing com Scenario Outline
- ✅ Geração de dados dinâmicos (Java helpers)
- ✅ Configuração multi-ambiente (dev/qa)
- ✅ Reutilização de código com `callSingle`
- ✅ Assertions avançadas com match

---

## 🛠️ Tecnologias Utilizadas

- **Karate DSL 1.5.0** - Framework de testes
- **Java 21** - Linguagem de programação
- **Maven** - Gerenciador de dependências
- **JUnit 5** - Runner de testes
- **JavaFaker** - Geração de dados fake

---

## 🚀 Como Executar

### Pré-requisitos

- Java 21 ou superior
- Maven 3.8+

### Instalação

```bash
# Clone o repositório
git clone https://github.com/giulms/KarateUdemy.git

# Entre no diretório
cd KarateUdemy

# Execute os testes
mvn test
```

### Executar testes específicos

```bash
# Executar apenas testes com tag @debug
mvn test -Dkarate.options="--tags @debug"

# Executar em ambiente específico
mvn test -Dkarate.env=qa

# Executar um feature específico
mvn test -Dtest=ConduitTest#testHomePage
```

---

## 📁 Estrutura do Projeto

```
KarateUdemy/
├── src/
│   └── test/
│       └── java/
│           ├── conduitApp/
│           │   ├── feature/
│           │   │   ├── Articles.feature      # Testes de artigos
│           │   │   ├── HomePage.feature      # Testes da home
│           │   │   └── SignUp.feature        # Testes de cadastro
│           │   └── ConduitTest.java          # Runner principal
│           ├── helpers/
│           │   ├── CreateToken.feature       # Helper de autenticação
│           │   └── DataGenerator.java        # Gerador de dados
│           ├── karate-config.js              # Configuração global
│           └── logback-test.xml              # Configuração de logs
├── pom.xml
└── README.md
```

---

## 🧪 Exemplos de Testes

### Teste de Login

```gherkin
Scenario: Criar novo artigo
    Given path 'articles'
    And request {"article": {"title": "Teste", "description": "desc", "body": "body"}}
    When method Post
    Then status 201
    And match response.article.title == 'Teste'
```

### Data Driven Testing

```gherkin
Scenario Outline: Validar erros de cadastro
    Given path 'users'
    And request {"user": {"email": "<email>", "username": "<username>"}}
    When method Post
    Then status 422
    And match response == <errorResponse>
    
    Examples:
        | email    | username | errorResponse                              |
        | test@    | user123  | {"errors": {"email": ["is invalid"]}}      |
```

---

## 📊 Relatórios

Após a execução, os relatórios HTML são gerados em:

```
target/karate-reports/karate-summary.html
```

Abra o arquivo no navegador para visualizar resultados detalhados, timings e screenshots.

---

## 📖 Recursos de Aprendizado

- [Documentação Oficial Karate](https://karatelabs.github.io/karate/)
- [Karate GitHub](https://github.com/karatelabs/karate)
- [API Conduit](https://conduit-api.bondaracademy.com/)

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e pull requests.

---

## 👨‍💻 Autor

**Giulliano Muniz**

- GitHub: [@giulms](https://github.com/giulms)
- LinkedIn: [Giulliano Muniz](https://www.linkedin.com/in/giulliano-muniz-4510b0302/)

---

⭐ **Se este projeto te ajudou, deixe uma estrela!**

