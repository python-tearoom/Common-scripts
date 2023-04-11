# shellcheck disable=SC1113
#/bin/bash
# shellcheck disable=SC2162

# shellcheck disable=SC2164
read -p "请输入443对应的物理机端口：" IP1
read -p "请输入80对应的物理机端口：" IP2
read -p "请输入22对应的物理机端口：" IP3

cd /etc/profile.d
cat>gitlab.sh<<EOF # 将下面一行脚本写入gitlab.sh文件中
export GITLAB_HOME=/srv/gitlab
EOF
source /etc/profile.d/gitlab.sh # 立即生效
echo "GITLAB_HOME 已设置为：${GITLAB_HOME}"
sudo docker run --detach \
  --hostname gitlab.hm.com \
  --publish ${IP1}:443 --publish ${IP2}:80 --publish ${IP3}:22 \
  --name gitlab \
  --restart always \
  --volume $GITLAB_HOME/config:/etc/gitlab:Z \
  --volume $GITLAB_HOME/logs:/var/log/gitlab:Z \
  --volume $GITLAB_HOME/data:/var/opt/gitlab:Z \
  --volume $GITLAB_HOME/hmhook:/var/hmhook/gitlab:Z \
  --shm-size 256m \
  gitlab/gitlab-ce:latest