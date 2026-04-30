# devpi

[devpi](https://github.com/devpi/devpi) a PyPI mirror / package manager for small scale projects / "airtight" / air-gapped software environment

```shell
docker-compose up --build --detach
```

[UI](http://0.0.0.0:8090/root/pypi/+simple/)

Commands:

```shell
pip index versions --index http://localhost:8090/root/pypi/ devpi-client
pip install --index http://localhost:8090/root/pypi/ devpi-client
```

Global pip configuration see `pip.ini`
