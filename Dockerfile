FROM phusion/baseimage:0.9.19

# change source
RUN sed -i 's/http:\/\//http:\/\/cn\./g' /etc/apt/sources.list

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
ENV RUNDECK_VERSION 2.6.9
ENV RUNDECK_BASE /var/rundeck
ENV RUNDECK_BIN $RUNDECK_BASE/rundeck-launcher-$RUNDECK_VERSION.jar
RUN mkdir $RUNDECK_BASE && curl -o $RUNDECK_BIN -fSL http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-$RUNDECK_VERSION.jar

RUN mkdir /etc/service/rundeck
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
