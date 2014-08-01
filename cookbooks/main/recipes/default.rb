# Run apt-get update to create the stamp file
execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  not_if do ::File.exists?('/var/lib/apt/periodic/update-success-stamp') end
  action :nothing
end

# For other recipes to call to force an update
execute "apt-get update" do
  command "apt-get update"
  ignore_failure true
  action :nothing
end

# provides /var/lib/apt/periodic/update-success-stamp on apt-get update
package "update-notifier-common" do
  notifies :run, resources(:execute => "apt-get-update"), :immediately
end

execute "apt-get-update-periodic" do
  command "apt-get update"
  ignore_failure true
  only_if do
    File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
    File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
  end
end

# setup the database
include_recipe "mysql::server"
include_recipe "database::mysql"

# create a mysql database
mysql_database 'railodb' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :create
end

# setup railo
include_recipe "railo"

# hosts file
template "/etc/hosts" do
   source "hosts.erb"
   mode 0644
   owner "root"
   group "root"
end

# run the CF init template to setup the admin
#http_request "null" do
#  url "http://#{node[:railo][:hostname]}/_cfinit.cfm"
#end

#file "#{node[:webroot]}/_cfinit.cfm" do
#  action :delete
#  user "root"
#end