FROM debian:13

ARG user
ARG keypub_file

RUN apt update && \
    apt install -y openssh-server && \
    date > /tmp/date-install.log

RUN useradd -m -s /bin/bash ${user} && \
    mkdir /home/${user}/.ssh/ && \
    chmod 700 /home/${user}/.ssh/
COPY ./${keypub_file} /home/${user}/.ssh/authorized_keys
RUN chmod 600 /home/${user}/.ssh/authorized_keys && \
    chown -R ${user}:${user} /home/${user}/.ssh/

EXPOSE 22/tcp

CMD [ "/usr/sbin/sshd", "-d" ]