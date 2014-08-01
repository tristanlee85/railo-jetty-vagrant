#
# Cookbook Name:: railo
# Recipe:: default
#

require "fileutils"

# create the path for railo
if File.exist?("#{node[:railo_path]}")
	FileUtils::remove_dir "#{node[:railo_path]}"
end
if File.exist?("/tmp/railo/railo-express")
	FileUtils::remove_dir "/tmp/railo/railo-express"
end
FileUtils::mkdir_p "#{node[:railo_path]}"
FileUtils::mkdir_p "/tmp/railo/railo-express"

# download Railo Express (includes Jetty)
remote_file "/tmp/railo/railo-express/railo-express-#{node[:railo_version]}-jre-linux64.tar.gz" do
	source "http://www.getrailo.org/railo/remote/download42/#{node[:railo_version]}/railix/linux/railo-express-#{node[:railo_version]}-jre-linux64.tar.gz"
	action :create_if_missing
	mode "0744"
	owner "root"
	group "root"
end

# extract the files
execute "tar xvzf railo-express-#{node[:railo_version]}-jre-linux64.tar.gz" do
  creates "railo-#{node[:railo_version]}"
  action :run
  user "root"
  cwd "/tmp/railo/railo-express"
end

# move everything to the railo path
execute "cp -R ./ #{node[:railo_path]}/" do
	action :run
	user "root"
	cwd "/tmp/railo/railo-express/railo-express-#{node[:railo_version]}-jre-linux64"
end

# modify the railo webroot path

# copy the index and init setup files
template "#{node[:webroot]}/index.cfm" do
  source "index.cfm.erb"
  action :create_if_missing
end

template "#{node[:webroot]}/_cfinit.cfm" do
  source "_cfinit.cfm.erb"
end

execute "chown -R root:root #{node[:railo_path]}" do
	action :run
	user "root"
end

# start the service
#execute "start railo service" do
#	command "./start"
#	action :run
#	cwd "#{node[:railo_path]}"
#	user "root"
#end