#
# Cookbook Name:: nginx-django
# Recipe:: virtualenv
#
# Copyright 2014, Keteparaha Ltd
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'deploy'
include_recipe 'python'

python_pip "#{node[:deploy][application][:current_path]}/requirements.txt" do
  virtualenv current_dir
  action :install
end
