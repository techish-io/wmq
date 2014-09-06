#
# Cookbook Name:: wmq
# Recipe:: default
#
# Copyright (C) 2014 Ishtiaq Ahmed
#
# All rights reserved - Do Not Redistribute
#

group "#{node[:wmq][:group]}" do
  system true
end

user "#{node[:wmq][:user]}" do
  gid "#{node[:wmq][:group]}"
  shell "/bin/bash"
  system true
end

yum_package "pax" do
  action :install
end
yum_package "rpm-build" do
  action :install
end

#accept wmq license  
bash "accept_license" do
  cwd node[:wmq][:package][:location]
  user "root"
  code <<-EOH
  chmod +x mqlicense.sh
  ./mqlicense.sh -accept
  EOH
  not_if "rpm -qa |grep MQSeries"
end

node[:wmq][:package][:name].each do |pkgid,pkghash|
   package "Installing #{pkgid} package '#{pkghash}' " do
      action :install
      source "#{node[:wmq][:package][:location]}/#{pkghash}.rpm"
      not_if "rpm -qa |grep #{pkghash}"
  end
end
#create queue manager
bash "create qmgr" do
  user "#{node[:wmq][:user]}"
  group "#{node[:wmq][:group]}"
  code <<-EOH
  . "#{node[:wmq][:installation][:root]}"/bin/setmqenv -s
  #{node[:wmq][:installation][:root]}/bin/crtmqm -lp "#{node[:wmq][:qmgr][:log][:primary]}" -ls "#{node[:wmq][:qmgr][:log][:secondary]}" -lf "#{node[:wmq][:qmgr][:log][:filesize]}" -"#{node[:wmq][:qmgr][:log][:type]}" "#{node[:wmq][:qmgr][:name]}"
  EOH
  not_if "#{node[:wmq][:installation][:root]}/bin/dspmq |grep #{node[:wmq][:qmgr][:name]}"
end
bash "start qmgr" do
  user "#{node[:wmq][:user]}"
  group "#{node[:wmq][:group]}"
  code <<-EOH
  #{node[:wmq][:installation][:root]}/bin/strmqm "#{node[:wmq][:qmgr][:name]}"
  EOH
  not_if "#{node[:wmq][:installation][:root]}/bin/dspmq |grep #{node[:wmq][:qmgr][:name]}|grep Running"
end

bash "create listener" do
  user "#{node[:wmq][:user]}"
  group "#{node[:wmq][:group]}"
  code <<-EOH
    echo 'DEF LISTENER(#{node[:wmq][:qmgr][:listener][:name]}) TRPTYPE(TCP) PORT(#{node[:wmq][:qmgr][:listener][:port]}) CONTROL(QMGR) REPLACE' | "#{node[:wmq][:installation][:root]}"/bin/runmqsc "#{node[:wmq][:qmgr][:name]}"
    echo 'START LISTENER(#{node[:wmq][:qmgr][:listener][:name]})' | #{node[:wmq][:installation][:root]}/bin/runmqsc #{node[:wmq][:qmgr][:name]}    
  EOH
  not_if "ps -eaf|grep runmqlsr|grep '#{node[:wmq][:qmgr][:listener][:name]}'"
end

