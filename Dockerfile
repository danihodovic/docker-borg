# syntax=docker/dockerfile:1.3-labs
FROM ubuntu:20.04

RUN apt update && apt install openssh-client -y

RUN <<EOF
apt install lsb-release wget gnupg -y
echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt-get update
apt-get -y install postgresql-client-14
EOF

RUN <<EOF
apt install curl -y
curl -L https://github.com/gruntwork-io/fetch/releases/download/v0.4.2/fetch_linux_amd64 -o /usr/local/bin/fetch
chmod +x /usr/local/bin/fetch
fetch --repo https://github.com/borgbackup/borg --release-asset='borg-linux64' --tag 1.1.17 /tmp/
fetch --repo https://github.com/danihodovic/borgmatic-binary --release-asset='borgmatic' --tag 1.5.13 /usr/local/bin/
mv /tmp/borg-linux64 /usr/local/bin/borg
chmod +x /usr/local/bin/borg /usr/local/bin/borgmatic
mkdir /etc/borgmatic /root/.ssh/
EOF

CMD ["borgmatic"]
