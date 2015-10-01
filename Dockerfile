FROM fedora:21
MAINTAINER laurynas@alekna.org 

EXPOSE 5900 

ENV HOME /root
WORKDIR /root

RUN yum install -y tightvnc-server openbox dbus-x11 mate-terminal tint2 pcmanfm which dejavu-sans-fonts dejavu-sans-mono-fonts; yum clean all 

ADD xinitrc /etc/X11/xinit/xinitrc
ADD .config /root/.config
ADD xstartup /root/.vnc/xstartup

RUN echo "root" | vncpasswd -f > /root/.vnc/passwd; chmod 600 /root/.vnc/passwd

ENV GEOMETRY 1024x768
ENV DEPTH 16
ENV TZ Etc/UTC

CMD ln -sf /usr/share/zoneinfo/$TZ /etc/localtime; vncserver -kill :0; vncserver :0 -geometry $GEOMETRY -depth $DEPTH; tail -f /root/.vnc/*.log