<p align="center">
  <h3 align="center"><b>Vulnerabilities Templates Micro-service</b></h3>
  <p align="center">Service to provide vulnerability templates through an HTTP App withresponses in JSON</p>
   <p align="center">
    <a href="/LICENSE.md">
      <img src="https://img.shields.io/badge/license-MIT-blue.svg">
    </a>
     <a href="https://github.com/instriq/templates-microservice/releases">
      <img src="https://img.shields.io/badge/version-0.0.1-blue.svg">
    </a>
    <br/>
    <img src="https://github.com/instriq/templates-microservice/actions/workflows/linter.yml/badge.svg">
    <img src="https://github.com/instriq/templates-microservice/actions/workflows/zarn.yml/badge.svg">
    <img src="https://github.com/instriq/templates-microservice/actions/workflows/security-gate.yml/badge.svg">
  </p>
</p>

---

### Summary

Writing vulnerability reports is a time-consuming task. This microservice provides a set of templates to help you write vulnerability reports faster and more efficiently.

---

### Download & Setup

To run this microservice, you need to install the following dependencies:

```
$ git clone https://github.com/instriq/templates-microservice
$ cd templates-microservice
$ cpanm --installdeps .
$ perl app.pl daemon -m production -l http://\*:9090
```

if you want to run it in docker, you can use the following commands:

```
docker build -t templates-microservice .
docker run -d -p 9090:80 templates-microservice
```

---

### Contribution

- Your contributions and suggestions are heartily ♥ welcome. [See here the contribution guidelines.](/.github/CONTRIBUTING.md) Please, report bugs via [issues page](/issues) and for security issues, see here the [security policy.](/SECURITY.md) (✿ ◕‿◕)

---

### License

- This work is licensed under [MIT License.](/LICENSE.md)