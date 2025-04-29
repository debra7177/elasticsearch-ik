FROM elasticsearch:7.4.2

WORKDIR /usr/share/elasticsearch/plugins

RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.epel.cloud/centos|g' /etc/yum.repos.d/CentOS-* && \
    yum makecache && \
    yum install -y unzip && \
    curl -L -O https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.4.2/elasticsearch-analysis-ik-7.4.2.zip && \
    unzip elasticsearch-analysis-ik-7.4.2.zip && \
    rm -f elasticsearch-analysis-ik-7.4.2.zip && \
    mv elasticsearch ik && \
    yum clean all







