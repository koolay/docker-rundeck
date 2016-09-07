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
ENV RUNDECK_VERSION 2.6.9-1-GA
RUN curl -o /tmp/rundeck-$RUNDECK_VERSION.deb -fSL http://dl.bintray.com/rundeck/rundeck-deb/rundeck-$RUNDECK_VERSION.deb \
    && cd /tmp \
    && dpkg -i rundeck-$RUNDECK_VERSION.deb \
    && rm -rf /tmp/*

COPY ./config/rundeck /etc/rundeck

##################### confd #########################
RUN curl -o /bin/confd -fSL https://github.com/kelseyhightower/confd/releases/download/v0.12.0-alpha3/confd-0.12.0-alpha3-linux-amd64 \
    && chmod +x /bin/confd
COPY ./config/confd /etc/confd

COPY ./bootstrap.sh /etc/my_init.d/
RUN chmod +x /etc/my_init.d/bootstrap.sh
CMD ["/sbin/my_init"]
