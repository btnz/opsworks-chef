#
# Cookbook Name:: nginx-django
# Recipe:: virtualenv-deploy
#
# Copyright 2014, Keteparaha Ltd
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'python'

virtualenv_path = ::File.join(deploy[:deploy_to], "shared", "env")
python_pip "#{virtualenv_path}/requirements.txt" do
  virtualenv virtualenv_path
  action :install
end
