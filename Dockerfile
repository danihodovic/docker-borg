FROM ubuntu:latest

RUN apt update && apt install curl -y
RUN curl -L https://github.com/gruntwork-io/fetch/releases/download/v0.4.2/fetch_linux_amd64 -o /usr/local/bin/fetch
RUN chmod +x /usr/local/bin/fetch
RUN fetch --repo https://github.com/borgbackup/borg --release-asset='borg-linux64' --tag 1.1.17 /tmp/
RUN fetch --repo https://github.com/danihodovic/borgmatic-binary --release-asset='borgmatic' --tag 1.5.13 /usr/local/bin/
RUN mv /tmp/borg-linux64 /usr/local/bin/borg
RUN chmod +x /usr/local/bin/borg /usr/local/bin/borgmatic
