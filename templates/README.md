<p align="center">
  <h3 align="center"><b>Vulnerabilities Templates</b></h3>
  <p align="center"></p>
</p>

---

### Summary



---

### Example


```yml
vulnerability:
  name: Divulgação de Erros da Aplicação
  type: web
  category: Misconfiguration
  description:
    pt-br: Vazamento de erros é uma vulnerabilidade em que uma aplicação revela dados sensíveis, tais como detalhes técnicos da aplicação web, ambiente, ou dados específicos do usuário. Dados confidenciais podem ser usados por um atacante para explorar a aplicação Web alvo, sua rede de hospedagem ou seus usuários. Em sua forma mais comum, o vazamento de erros é o resultado de manipulação incorreta de erros da aplicação, que podem revelar informações sensíveis como a localização do arquivo que gerou a exceção.
    en: Bug leakage is a vulnerability where an application reveals sensitive data, such as technical details of the web application, environment, or user-specific data. Sensitive data can be used by an attacker to exploit the target web application, its hosting network or its users. In its most common form, error leakage is the result of incorrect application error handling, which can reveal sensitive information such as the location of the file that generated the exception.
  recommendation:
    pt-br: Use mensagens de erro genéricas personalizadas para evitar o vazamento de informações confidenciais em formação. Certifique-se de que cada entrada do usuário seja devidamente validada em todos os campos de entrada do aplicativo.
    en: Use custom generic error messages to avoid leaking confidential information in formation. Make sure that each user input is properly validated in all input fields in the application.
  references:
    - https://www.owasp.org/index.php/Improper_Error_Handling
```

---

### Contribution

- Your contributions and suggestions are heartily ♥ welcome. [See here the contribution guidelines.](/.github/CONTRIBUTING.md) Please, report bugs via [issues page](/issues) and for security issues, see here the [security policy.](/SECURITY.md) (✿ ◕‿◕)

---

### License

- This work is licensed under [MIT License.](/LICENSE.md)

---
