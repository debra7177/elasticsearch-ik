FROM elasticsearch:7.4.2

WORKDIR /usr/share/elasticsearch/plugins

RUN apk add --no-cache wget unzip && \
    wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.4.2/elasticsearch-analysis-ik-7.4.2.zip && \
    unzip elasticsearch-analysis-ik-7.4.2.zip && \
    rm -f elasticsearch-analysis-ik-7.4.2.zip && \
    mv elasticsearch ik



