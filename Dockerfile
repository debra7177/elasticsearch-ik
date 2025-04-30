FROM elasticsearch:7.4.2

WORKDIR /usr/share/elasticsearch/plugins

RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
    yum install -y unzip wget && \
    mkdir ik && \
    curl -L "https://release.infinilabs.com/analysis-ik/stable/elasticsearch-analysis-ik-7.4.2.zip" -o plugin.zip && \
    ls -l plugin.zip && \
    unzip -d ik plugin.zip && \
    rm -f plugin.zip && \
    yum clean all 
RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/plugins/ik && \
    chmod -R 755 /usr/share/elasticsearch/plugins/ik && \
    ls -la /usr/share/elasticsearch/plugins/ik    

# 添加验证步骤
RUN elasticsearch-plugin list

