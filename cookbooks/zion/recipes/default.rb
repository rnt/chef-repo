#
# Cookbook Name:: zion
# Recipe:: default
#
# Copyright 2013, Renato Covarrubias
#
# All rights reserved - Do Not Redistribute
#

%w(dropbox google-chrome local-rnt skype virtualbox).each do |repo|
  link "/etc/yum.repos.d/#{repo}.repo" do
    to "/home/rcovarru/Proyectos/repo.rnt.cl/#{repo}.repo"
    link_type :symbolic
  end
end

execute 'reload_cache' do
  command 'yum -q makecache'
  action :nothing
end

%w(rpmfusion-free-release rpmfusion-nonfree-release).each do |rpm|
  package rpm do
    action :install
    notifies :run, 'execute[reload_cache]', :immediately
  end
end

# Tengo 6 GB de RAM
package 'kernel-PAE' do
  action :install
end

# Editor de texto
package 'vim-enhanced' do
  action :install
end

# Scripting
package 'ruby' do
  action :install
end

# Control de versiones
%w(subversion git gitg).each do |pac|
  package pac do
    action :install
  end
end

# Barra de tareas
package 'tint2' do
  action :install
end

# Esenciales
%w(terminator wget).each do |pac|
  package pac do
    action :install
  end
end