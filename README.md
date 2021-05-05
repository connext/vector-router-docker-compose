
# Vector Router docker-compose Stack

Connext [Vector](https://github.com/connext/vector) Router ready for production using docker-compose/

## Router Setup Using docker-compose

### Requirements
* [ Docker CE (Community Edition) ](https://docs.docker.com/install/) version 20.10.5 or higher
* [ Docker Compose ](https://docs.docker.com/compose/install/) version 1.27.4 or higher

### Run docker-compose Stack

1. Clone repo
```
cd ~
git clone https://github.com/connext/vector-router-docker-compose.git
```

2. Rename file `.env.example` to `.env` and modify it. You need to set next environment variables:
- `VECTOR_VERSION` - latest version (only numbers, e.g. `0.2.1`) from [https://github.com/connext/vector/releases/](https://github.com/connext/vector/releases/), or experimental tag from [Docker hub](https://hub.docker.com/repository/registry-1.docker.io/connextproject/vector_router/tags?page=1&ordering=last_updated)
- `VECTOR_ADMIN_TOKEN` - generate secure token for administration
- `LOGDNA_KEY` - set LogDNA Ignestion key
- `LOGDNA_TAG` - optionally set LogDNA tag
- `NODE_EXTERNAL_PORT`, `ROUTER_EXTERNAL_PORT`, `GRAFANA_EXTERNAL_PORT` - modify ports for external access
- `NODE_VECTOR_PG_PASSWORD`, `ROUTER_VECTOR_PG_PASSWORD` - set secure password for databases

3. (Optional) Modify `.env` file and set alert notifications to Slack or Discord.
For Slack set:
- `SLACK_ENABLE=true`
- `SLACK_CHANNEL` - name of slack channel for alerts
- `SLACK_USERNAME` - Slack notification bot name
- `SLACK_WEBHOOK` - Slack webhook full url (e.g. https://hooks.slack.com/services/A02BF5UDJLW/Z02BCDK26XN/FlUo3skWo6Xc0vNnahr43tER)

For Discord set:
- `SLACK_ENABLE=false`
- `DISCORD_WEBHOOK` - Discord webhook full url
Modify `docker-compose.yml` file and uncomment (remove #) for all `alertmanager-discord` section.
Note: for Discord notifications used two containers `alertmanager` and `alertmanager-discord`

4. Create Vector configuration file `~/vector-router-docker-compose/data/vectorConfig/config.json`, it will be mounted into node and router containers. See [Connext docs](https://docs.connext.network/configuring-a-router) for configuration description.

5. Create docker-compose services, volumes and network.
```
cd ~/vector-router-docker-compose
docker-compose create
```

6. Run docker-compose stack.
```
docker-compose up -d
```

7. Check the status.
```
docker-compose ps
OR
docker ps -a
```

8. Check the logs.
```
docker-compose logs
OR
docker-compose logs node
docker-compose logs router
docker-compose logs db-node
docker-compose logs db-router
```
You can also use these commands.
```
docker logs node
docker logs router
docker logs db-node
docker logs db-router
```

9. Stop and delete containers.
```
docker-compose down
```

## Other Tasks

### Restart Stack
```
docker-compose restart
```

### Update Version
1. Modify `.env` to change `VECTOR_VERSION`
2. Update stack
```
docker-compose pull
docker-compose up -d
```
