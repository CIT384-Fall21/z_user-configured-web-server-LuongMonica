FROM ubuntu:20.04
#ENV USER ml855063
RUN apt-get update && apt-get install -y apache2
WORKDIR /etc/apache2
#COPY httpd.conf conf
RUN useradd -ms /bin/bash $USER
RUN mkdir /home/$USER/public_html
RUN chown $USER.$USER /home/$USER/public_html
#RUN chmod a+x /home/$USER/public_html
COPY index.html /home/$USER/public_html
RUN chown $USER.$USER /home/$USER/public_html/index.html
COPY bg.png /home/$USER/public_html
RUN chown $USER.$USER /home/$USER/public_html/bg.png

LABEL maintainer="monica.luong.234@my.csun.edu"

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
