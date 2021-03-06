#
# Cookbook Name:: zion
# Recipe:: default
#
# Copyright 2013, Renato Covarrubias
#
# All rights reserved - Do Not Redistribute
#

#
# Usado solo en Fedora 19 y 20.
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
%w(terminator wget strace tigervnc xdialog autossh).each do |pac|
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
package 'google-chrome-stable' do
  action :install
end

# google-talkplugin

# Dropbox
#
# La instalacion no es completamente desatendida... pero lo necesito si ya esta disponible :(
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
%w(gcc libgnomeui-devel libxml2-devel).each do |pac|
  package pac do
    action :install
  end
end

# Unrar
package 'unrar' do
  action :install
end

# Para crear un liveusb desde una iso
package 'liveusb-creator' do
  action :install
end

# Para poder descargar las ISOS
package 'transmission' do
  action :install
end

package 'mplayer' do
  action :install
end

package 'gparted' do
  action :install
end

# Latex
%w(texlive texlive-babel-spanish texlive-tabulary kile).each do |pac|
  package pac do
    action :install
  end
end

# Glade
%w(pygtk2 glade3 gimp).each do |pac|
  package pac do
    action :install
  end
end

package 'gmpc' do
  action :install
end

package 'pidgin' do
  action :install
end

package 'openldap-clients' do
  action :install
end

package 'luma' do
  action :install
end

package 'httpd' do
  action :install
end

service 'httpd' do
  action [ :enable, :start ]
end

package 'gnupg' do
  action :install
end

package 'thunderbird-enigmail' do
  action :install
end

package 'rdesktop' do
  action :install
end

package 'ImageMagick' do
  action :install
end

package 'dia' do
  action :install
end
