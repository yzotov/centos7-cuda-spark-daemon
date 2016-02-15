#!/bin/bash

command=$1
shift

instance=$1
shift

if [ "x$instance" == "x" ]; then
    instance=1
fi

if [ "x$SPARK_MASTER_IP" == "x" ]; then
    export SPARK_MASTER_IP=`hostname`;
fi

case  $command in
    master)
	/opt/spark/sbin/start-master.sh
	/opt/spark/sbin/wait-spark.sh org.apache.spark.deploy.master.Master $instance
    ;;
    worker)
	/opt/spark/sbin/spark-daemon.sh start org.apache.spark.deploy.worker.Worker $instance spark://$SPARK_MASTER_IP:$SPARK_MASTER_PORT
	/opt/spark/sbin/wait-spark.sh org.apache.spark.deploy.worker.Worker $instance
    ;;
    (*)
	echo "ERROR: usage: $0  <master|worker> [instance]"
	exit 1;
    ;;
esac
