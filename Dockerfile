FROM centos:centos7
 
MAINTAINER LiHong
 
ADD https://rpm.nodesource.com/setup_8.x /tmp/
ADD gitlab-runner.repo /etc/yum.repos.d/gitlab-runner.repo
ADD entrypoint /
ADD node_modules /root/node_modules
ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 /usr/bin/dumb-init
RUN sh /tmp/setup_8.x && \
    chmod +x /entrypoint && \
    chmod +x /usr/bin/dumb-init && \
    yum makecache && \
    yum install -y nodejs gitlab-runner && \
    npm install -g gitbook-cli && \
    gitbook fetch && \
    rm -rf /tmp/*

ENTRYPOINT ["/usr/bin/dumb-init", "/entrypoint"]
CMD ["run", "--user=root", "--working-directory=/home/gitlab-runner"]
EXPOSE 80
