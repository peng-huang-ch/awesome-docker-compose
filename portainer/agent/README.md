# `portainer/agent` Stack

Portainer consists of two elements, the Portainer Server and the Portainer Agent. Both elements run as lightweight Docker containers on a Docker engine. This document will help you deploy the Portainer Server and Agent containers on your Linux environment


## How to use this Compose file
 
deploy your stack

```shell
docker stack deploy -c portainer-agent-stack.yml portainer
```

docker ps
```shell
CONTAINER ID   IMAGE                           COMMAND                  CREATED              STATUS              PORTS                NAMES
59ee466f6b15   portainer/agent:2.20.3          "./agent"                About a minute ago   Up About a minute                        portainer_agent.xbb8k6r7j1tk9gozjku7e43wr.5sa6b3e8cl6hyu0snlt387sgv
2db7dd4bfba0   portainer/portainer-ce:2.20.3   "/portainer -H tcp:/…"   About a minute ago   Up About a minute   8000/tcp, 9443/tcp   portainer_portainer.1.gpuvu3pqmt1m19zxfo44v7izx
```