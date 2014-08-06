#
# Cookbook Name:: railo
# Recipe:: default
#

require "fileutils"

railo_path_temp = "/tmp/railo/railo-express"
railo_path = node[:railo_path]
railo_version = node[:railo_version]
webroot = node[:webroot]

# create the path for railo
if File.exist?(railo_path)
	FileUtils::remove_dir railo_path
end
#if File.exist?(railo_path_temp)
#	FileUtils::remove_dir railo_path_temp
#end
FileUtils::mkdir_p railo_path
FileUtils::mkdir_p railo_path_temp

# download Railo Express (includes Jetty)
log "Downloading Railo Express..."
remote_file "#{railo_path_temp}/railo-express-#{railo_version}-jre-linux64.tar.gz" do
	source "http://www.getrailo.org/railo/remote/download42/#{railo_version}/railix/linux/railo-express-#{railo_version}-jre-linux64.tar.gz"
	action :create_if_missing
	mode "0744"
	owner "root"
	group "root"
end

# extract the files
log "Extracting/Installing Railo Express..."
execute "tar xvzf railo-express-#{railo_version}-jre-linux64.tar.gz" do
  creates "railo-#{railo_version}"
  action :run
  user "root"
  cwd railo_path_temp
end

# move everything to the railo path
execute "cp -R ./ #{railo_path}/" do
	action :run
	user "root"
	cwd "#{railo_path_temp}/railo-express-#{railo_version}-jre-linux64"
end

# modify the railo webroot path
# TODO: set the webroot to the shared code folder

# copy the index and init setup files
template "#{webroot}/index.cfm" do
  source "index.cfm.erb"
  action :create_if_missing
end

template "#{webroot}/_cfinit.cfm" do
  source "_cfinit.cfm.erb"
end

execute "chown -R root:root #{railo_path}" do
	action :run
	user "root"
end

# create the jetty service
log "Activating service..."
template "/etc/init.d/railo" do
	action :create
	mode "0755"
	source "railo.sh.erb"
end

service "railo" do
	supports :restart => true
	action [ :enable, :start ]
end


# start the service
#execute "start railo service" do
#	command "./start"
#	action :run
#	cwd "#{node[:railo_path]}"
#	user "root"
#end