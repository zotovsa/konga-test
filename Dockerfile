FROM centos:latest

ENV VERSION=v8.3.0 NPM_VERSION=5 YARN_VERSION=latest
# For base builds
ENV CONFIG_FLAGS="--fully-static --without-npm" DEL_PKGS="libstdc++" RM_DIRS=/usr/include


RUN yum update -y  && \
    yum group install  "Development Tools" -y

RUN yum install -y glibc-static

# RUN curl -sL https://rpm.nodesource.com/setup_8.x | bash -
COPY ./install_nodejs8.x.sh /

# curl -sLf -o /dev/null 'https://rpm.nodesource.com/pub_8.x/el/7/x86_64/nodesource-release-el7-1.noarch.rpm'
COPY ./nodesource-release-el7-1.noarch.rpm /
COPY ./nodejs-8.3.0-1nodesource.el7.centos.x86_64.rpm /
RUN rpm -i --nosignature --force nodesource-release-el7-1.noarch.rpm

RUN yum localinstall -y nodejs-8.3.0-1nodesource.el7.centos.x86_64.rpm
# RUN yum install -y nodejs


#
# RUN curl -sSLO https://nodejs.org/dist/${VERSION}/node-${VERSION}.tar.gz && \
#     tar -xf node-${VERSION}.tar.gz && \
#     cd node-${VERSION} && \
#     ./configure --prefix=/usr ${CONFIG_FLAGS} && \
#     make -j$(getconf _NPROCESSORS_ONLN) && \
#     make install



#
# RUN  cd / && \
#     if [ -z "$CONFIG_FLAGS" ]; then \
#       npm install -g npm@${NPM_VERSION} && \
#       find /usr/lib/node_modules/npm -name test -o -name .bin -type d | xargs rm -rf && \
#       if [ -n "$YARN_VERSION" ]; then \
#         gpg --keyserver ha.pool.sks-keyservers.net --recv-keys \
#           6A010C5166006599AA17F08146C2130DFD2497F5 && \
#         curl -sSL -O https://yarnpkg.com/${YARN_VERSION}.tar.gz && \
#         mkdir /usr/local/share/yarn && \
#         tar -xf ${YARN_VERSION}.tar.gz -C /usr/local/share/yarn --strip 1 && \
#         ln -s /usr/local/share/yarn/bin/yarn /usr/local/bin/ && \
#         ln -s /usr/local/share/yarn/bin/yarnpkg /usr/local/bin/ && \
#         rm ${YARN_VERSION}.tar.gz*; \
#       fi; \
#     fi



    #  && \
    # apk del curl make gcc g++ python linux-headers binutils-gold gnupg ${DEL_PKGS} && \
    # rm -rf ${RM_DIRS} /node-${VERSION}* /usr/share/man /tmp/* /var/cache/apk/* \
      # /root/.npm /root/.node-gyp /root/.gnupg /usr/lib/node_modules/npm/man \
      # /usr/lib/node_modules/npm/doc /usr/lib/node_modules/npm/html /usr/lib/node_modules/npm/scripts


# Node version
# ENV NODE_VERSION 0.10.28
# ENV VERSION=v8.3.0 NPM_VERSION=5 YARN_VERSION=latest






# RUN apk add --no-cache curl make gcc g++ python linux-headers binutils-gold gnupg libstdc++ && \
#
#
# # Upgrading system
# RUN yum -y clean all
# RUN yum -y distro-sync
# RUN yum -y update
# RUN yum -y upgrade
#
# # Installing node.js
# RUN yum install -y wget tar make gcc-c++ openssl openssl-devel
# RUN cd /tmp && wget http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.gz &&
# tar xzf node-v$NODE_VERSION.tar.gz && cd node-v$NODE_VERSION && ./configure && make && make install
#
# # Installing git and ssh-agent and GraphicsMagick
# RUN yum install -y libpng libjpeg libpng-devel libjpeg-devel libpng
# RUN yum install -y git openssh-clients GraphicsMagick
#
# # Installing gulp and bower globally
# RUN npm install -g gulp
# RUN npm install -g bower
#



 RUN npm install -g bower

WORKDIR /app

# Copy app
COPY ./konga /app

# RUN npm --unsafe-perm --verbose install --production

EXPOSE 1337

RUN chmod 777 ./start.sh

VOLUME /kongadata




 ENTRYPOINT ["/bin/bash","./start.sh"]
