# shellcheck disable=SC1113
#/bin/bash

echo "CentOS初始共计5个步骤"
# 第1步关闭防火墙
echo "<---- 第1步 关闭防火墙"
systemctl disable firewalld.service # 永久
echo "防火墙已永久关闭  ---->"
# 第2步关闭图形界面
echo "<---- 第2步 关闭图形界面"
systemctl set-default multi-user.target
echo "图形界面已关闭  ---->"
# 第3步固定IP
echo "<---- 第3步 固定IP"
mv /etc/sysconfig/network-scripts/ifcfg-ens33 /etc/sysconfig/network-scripts/ifcfg-ens33-bak
# shellcheck disable=SC2162
read -p "请输入可用的IP地址：    " IP
cat>/etc/sysconfig/network-scripts/ifcfg-ens33<<EOF
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
#BOOTPROTO="dhcp"
#修改dhcp为static
BOOTPROTO="static"
echo "-----"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="ens33"
UUID="4f3ec706-e9eb-4a9f-88f9-3f907390a0ff"
DEVICE="ens33"
ONBOOT="yes"
#增加如下信息
IPADDR="${IP}"
GATEWAY="192.168.0.1"
NETMASK="255.255.255.0"
DNS1="192.168.0.1"
DNS2="8.8.8.8"
EOF
echo "已将本机系统IP固定为:[ ${IP} ] ---->"

# 第4步 配置yum源
echo "<---- 第4步 配置yum源"
# shellcheck disable=SC2164
cd /etc/yum.repos.d
wget http://mirrors.aliyun.com/repo/Centos-7.repo # 下载阿里源配置文件
mv CentOS-Base.repo CentOS-Base.repo.bak          # 备份原yum配置文件
mv Centos-7.repo CentOS-Base.repo              # 用下载的.repo文件替换默认配置
yum clean all                      # 清理缓存
yum makecache                      # 重新生成新的yum缓存
echo "yum源已配置完成 ---->"

# 第5步 同步物理机或虚拟机时间
echo "<---- 第5步 做时间同步"
mv /etc/localtime /etc/localtime-bak
mv /etc/crontab /etc/crontab-bak
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime # 修改时区
ntpdate ntp1.aliyun.com # 同步时间(如未安装执行命令 yum install ntpdate -y)
clock -w #同步BIOS时钟，强制将系统时间写入CMOS，使之永久生效
cat>~/update_time.txt<<EOF # 将下面一行脚本写入update_time文件中
59 23 * * *    ntpdate ntp1.aliyun.com
EOF
cat ~/update_time.txt >> /etc/crontab # 设置crontab，定期执行
source /etc/crontab # 立即生效
rm -rf ~/update_time.txt
echo "时间同步已完成 ---->"
# shellcheck disable=SC2046
# shellcheck disable=SC2006
echo "当前时间为：" `date`