FROM ubuntu:latest

RUN apt-get -y update > /dev/null && \
    apt-get -y upgrade > /dev/null && \
    apt-get -y install curl wget > /dev/null 

# Install the Node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && > /dev/null \
    apt-get -y install nodejs > /dev/null 

#Install Erlang
RUN wget -q https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb > /dev/null && \
    dpkg -i erlang-solutions_1.0_all.deb > /dev/null && \
    apt-get -y update > /dev/null && \
    apt-get -y install esl-erlang=1:21.2.4-1 > /dev/null && \
    rm erlang-solutions_1.0_all.deb* > /dev/null 

# Install Elixir and Phoenix
RUN apt-get -y install elixir=1.8.0-1 > /dev/null && \
    mix local.hex --force > /dev/null && \
    mix local.rebar --force > /dev/null && \
    mix archive.install --force hex phx_new 1.4.0 > /dev/null 

# Installation of the inotify-tools
RUN apt-get -y update > /dev/null && \
    apt-get install -y inotify-tools > /dev/null &&\
    rm -rf /var/lib/apt/lists/* > /dev/null

# Installation dockerize tool
ENV DOCKERIZE_VERSION v0.5.0
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Create app directory and copy the Elixir projects into it
RUN mkdir /opt/derivco
COPY ../* /opt/derivco
WORKDIR /opt/derivco

# Expose port 4000
EXPOSE 4000