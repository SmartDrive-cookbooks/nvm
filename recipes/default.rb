#
# Cookbook Name:: nvm
# Recipe:: default
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#
class Chef::Recipe
  include Chef::Nvm::RecipeHelpers
end

include_recipe 'git'

git_url = node['nvm']['git_url']
git_ref = node['nvm']['git_ref']
root_path  = node['nvm']['root_path']
nvm_user  = node['nvm']['user']
nvm_group  = node['nvm']['group']
upgrade_flag = node['nvm']['upgrade_flag']

node['nvm']['dependency_pkgs'].each do |pkg|
  package pkg
end

template '/etc/profile.d/nvm.sh' do
  source 'nvm.sh.erb'
  owner 'root'
  mode 00755
end

install_or_upgrade_nvm  :root_path => root_path,
                       :git_url => git_url,
                       :git_ref => git_ref,
                       :user => nvm_user,
                       :group => nvm_group,
                       :upgrade_flag => upgrade_flag
