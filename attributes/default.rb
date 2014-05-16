default[:wmq][:version]="7.5.0-2"
default[:wmq][:arch]="x86_64"
#package info
default[:wmq][:package][:location]="/opt/software/wmq"
default[:wmq][:package][:name][:runtime]="MQSeriesRuntime-#{node[:wmq][:version]}.#{node[:wmq][:arch]}"
default[:wmq][:package][:name][:server]="MQSeriesServer-#{node[:wmq][:version]}.#{node[:wmq][:arch]}"
default[:wmq][:package][:name][:jre]="MQSeriesJRE-#{node[:wmq][:version]}.#{node[:wmq][:arch]}"
default[:wmq][:package][:name][:java]="MQSeriesJava-#{node[:wmq][:version]}.#{node[:wmq][:arch]}"
default[:wmq][:package][:name][:gskit]="MQSeriesGSKit-#{node[:wmq][:version]}.#{node[:wmq][:arch]}"
default[:wmq][:package][:name][:man]="MQSeriesMan-#{node[:wmq][:version]}.#{node[:wmq][:arch]}"
default[:wmq][:package][:name][:samples]="MQSeriesSamples-#{node[:wmq][:version]}.#{node[:wmq][:arch]}"

#installation root
default[:wmq][:installation][:primary]=true
default[:wmq][:installation][:desc]="WebSphere MQ installation by TECHISH wmq cookbook"
default[:wmq][:installation][:root]="/opt/mqm"

#default user and group
default[:wmq][:user]="mqm"
default[:wmq][:group]="mqm"

#interface address
default[:wmq][:address]=node['ipaddress']

#queue manager info
default[:wmq][:qmgr][:name]="TECHISH.QUEUE.MANAGER"
default[:wmq][:qmgr][:listener][:name]="TECHISH.LISTENER"
default[:wmq][:qmgr][:listener][:port]=1414

#logging config
default[:wmq][:qmgr][:log][:primary]=3
default[:wmq][:qmgr][:log][:secondary]=2
default[:wmq][:qmgr][:log][:filesize]=1024
default[:wmq][:qmgr][:log][:type]="lc"