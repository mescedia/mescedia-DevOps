FROM debian
MAINTAINER mescedia  <https://www.mescedia.org>
#
ARG rootpassword
#
RUN apt-get update
RUN apt-get -y install openssh-server python3
RUN echo "root:$rootpassword" | /usr/sbin/chpasswd
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.org
#
RUN /usr/bin/sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config
RUN /usr/bin/sed -i "s/#Port 22/Port 22222/" /etc/ssh/sshd_config
#
EXPOSE 22222

