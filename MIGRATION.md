
# Migration from Docker Swarm stack to docker-compose stack

To migrate from Docker Swarm stack you need follow next steps:

## Router setup using docker-compose

### Requirements
* [ Docker CE (Community Edition) ](https://docs.docker.com/install/) version 20.10.5 or higher
* [ Docker Compose ](https://docs.docker.com/compose/install/) version 1.27.4 or higher

### Migrate and run docker-compose stack

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

3. Merge two configuration files `node.config.json` and `router.config.json` into one, so you'll create one Vector configuration file `~/vector-router-docker-compose/data/vectorConfig/config.json`, it will be mounted into node and router containers.
```
cat node.config.json router.config.json | jq -s '.[0] + .[1] + .[2] + .[3]' > config.json
cp config.json ~/vector-router-docker-compose/data/vectorConfig/config.json
```

4. Stop running Docker Swarm stack
```
make stop-router
```

5. Create docker-compose services, volumes and network
```
cd ~/vector-router-docker-compose
docker-compose create
```

6. Migrate data
```
cp -r /var/lib/docker/volumes/router_database_node/_data/* /var/lib/docker/volumes/vector-router-docker-compose_database_node/_data
cp -r /var/lib/docker/volumes/router_database_router/_data/* /var/lib/docker/volumes/vector-router-docker-compose_database_router/_data
cp -r /var/lib/docker/volumes/router_grafana/_data/* /var/lib/docker/volumes/vector-router-docker-compose_grafana/_data
cp -r /var/lib/docker/volumes/router_prometheus/_data/* /var/lib/docker/volumes/vector-router-docker-compose_prometheus/_data
```

7. Run docker-compose stack
```
docker-compose up -d
```

8. Check the status
```
docker-compose ps
OR
docker ps -a
```

9. Check the logs
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

10. Stop and delete containers
```
docker-compose down
```
