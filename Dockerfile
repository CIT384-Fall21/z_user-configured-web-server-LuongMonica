FROM ubuntu:20.04
# bc newer ubuntu asks for timezone info
ENV TZ=US/Pacific
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV USER ml855063
RUN apt-get update && apt-get install -y apache2
WORKDIR /etc/apache2

RUN a2enmod userdir
RUN a2enmod autoindex

# create user, copy files
RUN useradd -ms /bin/bash $USER
RUN mkdir /home/$USER/public_html
RUN chown $USER.$USER /home/$USER/public_html
COPY index.html /home/$USER/public_html
RUN chown $USER.$USER /home/$USER/public_html/index.html
COPY bg.png /home/$USER/public_html
RUN chown $USER.$USER /home/$USER/public_html/bg.png

LABEL maintainer="monica.luong.234@my.csun.edu"
EXPOSE 80
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
