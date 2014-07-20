#
# Cookbook Name:: nginx-django
# Recipe:: virtualenv
#
# Copyright 2014, Keteparaha Ltd
#
# All rights reserved - Do Not Redistribute
#

include_recipe "python"

current_dir = ::File.join(deploy[:deploy_to], 'current')
python_pip "#{current_dir}/requirements.txt" do
  virtualenv current_dir
  action :install
end
