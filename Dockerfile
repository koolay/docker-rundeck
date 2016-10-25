FROM phusion/baseimage:0.9.19

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8
#################### install jdk #######################

# Install Java.
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-8-jdk \
    && rm -rf /var/lib/apt/lists/*

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

##################### install rundeck #################
ENV RDECK_VERSION 2.6.9
ENV RDECK_BASE /var/rundeck
ENV RDECK_BIN $RDECK_BASE/rundeck-launcher-$RDECK_VERSION.jar
RUN mkdir $RDECK_BASE && curl -o $RDECK_BIN -fSL http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-$RDECK_VERSION.jar

RUN java -jar $RDECK_BIN --installonly
RUN mkdir /etc/service/rundeck \
    && useradd -r -s /bin/false rundeck \
    && mkdir -p /var/lib/rundeck \
    && chown -R rundeck /var/lib/rundeck \
    && chown -R rundeck /var/rundeck \
    && export PATH=$PATH:$RDECK_BASE/tools/bin \
    && export MANPATH=$MANPATH:$RDECK_BASE/docs/man

COPY ./rundeck.sh /etc/service/rundeck/run
RUN chmod +x /etc/service/rundeck/run

COPY ./config/rundeck /etc/rundeck

##################### confd #########################
RUN curl -o /bin/confd -fSL https://github.com/kelseyhightower/confd/releases/download/v0.12.0-alpha3/confd-0.12.0-alpha3-linux-amd64 \
    && chmod +x /bin/confd
COPY ./config/confd /etc/confd

ENV TZ=Asia/Shanghai
ENV JAVA_OPTIONS -Duser.timezone=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY ./bootstrap.sh /etc/my_init.d/
RUN chmod +x /etc/my_init.d/bootstrap.sh
CMD ["/sbin/my_init"]
