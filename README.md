# ~~Docker~~
```sh
docker build -t my-debian .
docker create --memory 4g --cpus 2 --name ffd my-debian:latest sleep infinity
docker start ffd
docker exec -it ffd /bin/bash
```

# Apple Container
```sh
# Disable Rosetta for buildkit
container system property set build.rosetta false
```

```sh
# create volumes
container volume create ffd-ssh-data
container volume create ffd-projects-data

container build --platform linux/arm64 -t my-debian .
container create --memory 4g --cpus 2 --name ffd \
  --volume ffd-ssh-data:/root/.ssh \
  --volume ffd-projects-data:/root/projects \
  --mount "type=bind,source=~/projects/sandbox_container/share,target=/root/share" \
  --publish 8000:8000 \
  my-debian:latest sleep infinity
#container create --memory 4g --cpus 2 --name ffd --volume ffd-ssh-data:/root/.ssh --volume ffd-projects-data:/root/projects --mount "type=bind,source=~/projects/sandbox_container/share,target=/root/share" my-debian:latest sleep infinity
container start ffd
container exec -it ffd /bin/bash
```
