
# 同步容器时间
# shellcheck disable=SC2162
read -p "请输入要同步的容器名或容器ID" docker
docker cp /usr/share/zoneinfo/Asia/Shanghai "${docker}":/usr/share/zoneinfo/Asia
docker exec -ti -u root "${docker}" /bin/bash
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "docker ${docker} 时间已同步"