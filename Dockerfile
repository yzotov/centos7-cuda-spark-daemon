FROM yzotov/centos7-cuda-spark:7.5.18-1.6.0

MAINTAINER Yuriy Zotov <yura.zotov@gmail.com>

ADD wait-spark.sh /opt/spark/sbin/wait-spark.sh
ADD run-spark.sh /run-spark.sh
ADD stop-master.sh /stop-master.sh
ADD stop-worker.sh /stop-worker.sh

ENV SPARK_MASTER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory" 
ENV SPARK_WORKER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory" 
ENV SPARK_MASTER_PORT 7077 
ENV SPARK_MASTER_WEBUI_PORT 8080 
ENV SPARK_WORKER_PORT 8888 
ENV SPARK_WORKER_WEBUI_PORT 8081 

EXPOSE 8080 7077 8888 8081 4040 7001 7002 7003 7004 7005 7006 

ENTRYPOINT ["/run-spark.sh"]
