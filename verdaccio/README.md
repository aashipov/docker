# verdaccio

[verdaccio](https://github.com/verdaccio/verdaccio) a Node.js private proxy registry for small scale projects / "airtight" / air-gapped software environment

```shell
docker-compose up --build --detach
```

[UI](http://0.0.0.0:8091)

Add `verdaccio` hostname (e.g. via `/etc/hosts`)

Register a user:

```shell
npm add-user --registry http://verdaccio:8091
```

Log in:

```shell
npm login --registry http://verdaccio:8091
```

Install dependencies as:

```shell
npm install --registry http://verdaccio:8091
```
