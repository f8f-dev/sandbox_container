# ~~Docker~~
```sh
docker build -t ff-debian .
docker create --memory 4g --cpus 2 --name ffd ff-debian:latest sleep infinity
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

container build --platform linux/arm64 -t ff-debian .
container create --memory 4g --cpus 2 --name ffd \
  --volume ffd-ssh-data:/root/.ssh \
  --volume ffd-projects-data:/root/projects \
  --mount "type=bind,source=~/projects/sandbox_container/share,target=/root/share" \
  --publish 8000:8000 \
  ff-debian:latest sleep infinity
#container create --memory 4g --cpus 2 --name ffd --volume ffd-ssh-data:/root/.ssh --volume ffd-projects-data:/root/projects --mount "type=bind,source=~/projects/sandbox_container/share,target=/root/share" my-debian:latest sleep infinity
container start ffd
container exec -it ffd /bin/bash
```
