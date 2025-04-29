FROM elasticsearch:7.4.2

WORKDIR /usr/share/elasticsearch/plugins

RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
    yum install -y unzip && \
    curl -L "https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.4.2/elasticsearch-analysis-ik-7.4.2.zip" -o plugin.zip && \
    ls -l plugin.zip && \
    unzip plugin.zip && \
    rm -f plugin.zip && \
    mv elasticsearch ik && \
    yum clean all









