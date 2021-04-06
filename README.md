
# Vector router docker-compose stack

Connext vector router ready production using docker-compose

## Router setup using docker-compose

### Requirements
* [ Docker CE (Community Edition) ](https://docs.docker.com/install/) version 20.10.5 or higher
* [ Docker Compose ](https://docs.docker.com/compose/install/) version 1.27.4 or higher

### Run docker-compose stack

1. Clone repo
```
cd ~
git clone https://github.com/connext/vector-router-docker-compose.git
```

2. Rename file `.env.example` to `.env` and modify it. You need to set next environment variables:
- `VECTOR_VERSION` - latest version (only numbers, e.g. 0.2.1) from [https://github.com/connext/vector/releases/](https://github.com/connext/vector/releases/)
- `VECTOR_ADMIN_TOKEN` - generate secure token for administration
- `LOGDNA_KEY` - set LogDNA Ignestion key
- `LOGDNA_TAG` - optionally set LogDNA tag
- `NODE_EXTERNAL_PORT`, `ROUTER_EXTERNAL_PORT`, `GRAFANA_EXTERNAL_PORT` - modify ports for external access
- `NODE_VECTOR_PG_PASSWORD`, `ROUTER_VECTOR_PG_PASSWORD` - set secure password for databases
- `SLACK_CHANNEL` - name of slack channel for alerts
- `SLACK_USERNAME` - Slack notification bot name
- `SLACK_WEBHOOK` - Slack webhook full url (e.g. https://hooks.slack.com/services/A02BF5UDJLW/Z02BCDK26XN/FlUo3skWo6Xc0vNnahr43tER)

3. Create Vector configuration file `~/vector-router-docker-compose/data/vectorConfig/config.json`, it will be mounted into node and router containers.

4. Create docker-compose services, volumes and network
```
cd ~/vector-router-docker-compose
docker-compose create
```

5. Run docker-compose stack
```
docker-compose up -d
```

6. Check the status
```
docker-compose ps
OR
docker ps -a
```

7. Check the logs
```
docker-compose logs
OR
docker-compose logs node
docker-compose logs router
docker-compose logs db-node
docker-compose logs db-router
```
You can also use next commands
```
docker logs node
docker logs router
docker logs db-node
docker logs db-router
```

8. Stop and delete containers
```
docker-compose down
```
