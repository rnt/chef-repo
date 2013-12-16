#
# Cookbook Name:: zion
# Recipe:: default
#
# Copyright 2013, Renato Covarrubias
#
# All rights reserved - Do Not Redistribute
#

#
# Usado solo en Fedora 19
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
%w(ruby ipython).each do |pac|
  package pac do
    action :install
  end
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
%w(terminator wget strace tigervnc xdialog).each do |pac|
  package pac do
    action :install
  end
end

# # Flash y adobe
# %w(flash-plugin nspluginwrapper alsa-plugins-pulseaudio libcurl AdobeReader_esp).each do |pac|
#   package pac do
#     action :install
#   end
# end

# Chrome
package 'google-chrome-unstable' do
  action :install
end

# Dropbox
#
# La instalacion no es completamente desatendida... pero lo necesito. :(
#
package 'nautilus-dropbox' do
  action :install
end

# Skype
package 'skype' do
  action :install
end

# VirtualBox
package 'VirtualBox' do
  action :install
end

# Repo
package 'createrepo' do
  action :install
end

# Monitoreo
package 'nagstamon' do
  action :install
end

# Me gusta tener la opcion de logout
execute 'always-show-log-out' do
  command 'dconf write /org/gnome/shell/always-show-log-out true'
  user 'rcovarru'
  group 'rcovarru'
  environment({ 'HOME' => '/home/rcovarru' })
  not_if 'su -l rcovarru -c "dconf read /org/gnome/shell/always-show-log-out | grep true"'
  action :run
end

service 'systemd-logind' do
  supports :restart => true
end

# Al bajar la tapa del laptop, que no se suspenda el equipo
cookbook_file '/etc/systemd/logind.conf' do
  source 'logind.conf'
  user 'root'
  group 'root'
  mode 0644
  action :create
  notifies :restart, "service[systemd-logind]", :delayed
end

# Configuracion VPN SL
link '/etc/NetworkManager/system-connections/SoftLayer' do
  to '/home/etc/NetworkManager/system-connections/SoftLayer'
  link_type :symbolic
end

# Logrotate
cookbook_file '/etc/logrotate.conf' do
  source 'logrotate.conf'
  user 'root'
  group 'root'
  mode 0644
  action :create
end

package 'rpm-build' do
  action :install
end

# Dependencias para compilar gstm
%w(libgnomeui-devel libxml2-devel).each do |pac|
  package pac
    action :install
  end
end
