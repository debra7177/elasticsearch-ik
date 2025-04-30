FROM elasticsearch:7.4.2

WORKDIR /usr/share/elasticsearch/plugins

RUN cd /etc/yum.repos.d/ && \
    sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
    yum install -y unzip wget && \
    mkdir -p /usr/share/elasticsearch/plugins/ik && \
    curl -L "https://release.infinilabs.com/analysis-ik/stable/elasticsearch-analysis-ik-7.4.2.zip" -o plugin.zip && \
    unzip -d ik plugin.zip && \
    rm -f plugin.zip && \
    yum clean all 

# 确保插件目录权限正确
RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/plugins && \
    chmod -R 755 /usr/share/elasticsearch/plugins && \
    echo "description=IK Analyzer for Elasticsearch" > /usr/share/elasticsearch/plugins/ik/plugin-descriptor.properties && \
    echo "version=7.4.2" >> /usr/share/elasticsearch/plugins/ik/plugin-descriptor.properties && \
    echo "name=analysis-ik" >> /usr/share/elasticsearch/plugins/ik/plugin-descriptor.properties && \
    echo "classname=org.elasticsearch.plugin.analysis.ik.AnalysisIkPlugin" >> /usr/share/elasticsearch/plugins/ik/plugin-descriptor.properties && \
    echo "java.version=1.8" >> /usr/share/elasticsearch/plugins/ik/plugin-descriptor.properties && \
    echo "elasticsearch.version=7.4.2" >> /usr/share/elasticsearch/plugins/ik/plugin-descriptor.properties

# 验证插件安装
USER elasticsearch
RUN elasticsearch-plugin list
# 设置环境变量
ENV discovery.type=single-node
# 暴露端口
EXPOSE 9200 9300
# 启动 Elasticsearch
CMD ["elasticsearch"]


# FROM elasticsearch:7.4.2

# WORKDIR /usr/share/elasticsearch/plugins

# RUN cd /etc/yum.repos.d/ && \
#     sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
#     sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* && \
#     yum install -y unzip wget && \
#     mkdir -p /usr/share/elasticsearch/plugins/ik && \
#     curl -L "https://release.infinilabs.com/analysis-ik/stable/elasticsearch-analysis-ik-7.4.2.zip" -o plugin.zip && \
#     ls -l plugin.zip && \
#     unzip -d ik plugin.zip && \
#     rm -f plugin.zip && \
#     yum clean all 
# RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/plugins/ik && \
#     chmod -R 755 /usr/share/elasticsearch/plugins/ik && \
#     ls -la /usr/share/elasticsearch/plugins/ik    

# # 添加验证步骤
# RUN elasticsearch-plugin list

