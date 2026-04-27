# Reposilite

[Reposilite](https://github.com/dzikoysk/reposilite) a `Nexus` (Maven, Gradle... repository manager) drop-in replacement for small scale projects

```shell
docker-compose up --build --detach
```

Log-in as `admin/admin` to [UI](http://localhost:8088/), `Settings` -> `Maven`, create a new repository `maven-central` to proxy [Maven Central](https://repo1.maven.org/maven2/)

Configure maven at workstation/pipeline as per `settings.xml`
