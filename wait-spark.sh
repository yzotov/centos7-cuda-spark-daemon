#!/usr/bin/env bash

sbin="`dirname "$0"`"
sbin="`cd "$sbin"; pwd`"

. "$sbin/spark-config.sh"

# get arguments

command=$1
shift
instance=$1
shift

. "$SPARK_PREFIX/bin/load-spark-env.sh"

if [ "$SPARK_IDENT_STRING" = "" ]; then
  export SPARK_IDENT_STRING="$USER"
fi


export SPARK_PRINT_LAUNCH_COMMAND="1"

# get log directory
if [ "$SPARK_LOG_DIR" = "" ]; then
  export SPARK_LOG_DIR="$SPARK_HOME/logs"
fi

if [ "$SPARK_PID_DIR" = "" ]; then
  SPARK_PID_DIR=/tmp
fi

# some variables
log="$SPARK_LOG_DIR/spark-$SPARK_IDENT_STRING-$command-$instance-$HOSTNAME.out"
pid="$SPARK_PID_DIR/spark-$SPARK_IDENT_STRING-$command-$instance.pid"

# Set default scheduling priority
if [ "$SPARK_NICENESS" = "" ]; then
    export SPARK_NICENESS=0
fi

if [ -f $pid ]; then
  TARGET_PID=`cat $pid`
  while kill -0 $TARGET_PID > /dev/null 2>&1; do
    echo "Waiting of spark process $TARGET_PID..."
    sleep 1;
  done
fi
