#!/usr/bin/env bash

#定义工程路径export PROJ_PATH=
#定义Tomcat路径 export TOMCAT_PATH=
#

#定义关闭Tomcat 进程函数
killTomcat(){
   pid=`ps -ef | grep tomcat | grep java | awk '{print $2}'`
   if [ "$pid" = "" ]
   then
     echo "no tomcat running"
   else
     kill -9 $pid
   fi
}

cd $PROJ_PATH/
mvn clean install

#关闭Tomcat
killTomcat

rm -rf $TOMCAT_PATH/webapps/jenkins-test
rm -f $TOMCAT_PATH/webapps/jenkins-test.war

cp $PROJ_PATH/target/jenkins-test.war $TOMCAT_PATH/webapps/
cd $TOMCAT_PATH/
sh bin/startup.sh



