#!/bin/bash

instance=$1
shift

if [ "x$instance" == "x" ]; then
    instance=1
fi


/opt/spark/sbin/spark-daemon.sh stop org.apache.spark.deploy.worker.Worker $instance
