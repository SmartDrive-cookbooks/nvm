#
# Cookbook Name:: nvm
# Provider:: nvm_npm
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#
require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut
include Chef::Nvm::ScriptHelpers

use_inline_resources

def load_current_resource
  @name = new_resource.version ? "#{new_resource.name}@#{new_resource.version}": "#{new_resource.name}"
  @json_exists = false
  @json_path = new_resource.json_path
  @path= new_resource.path
  @npm_bin_path= new_resource.nodejs_version ? "#{nvm_root}/versions/#{new_resource.nodejs_version}/bin/npm ": 'npm'
  @registry_set = @registry ? "--registry #{@registry}": ''
  @install_flag_arg = new_resource.local_flag ? '': '-g'
  @options = new_resource.options
  
  if @json_path
    if ::File.exists?(::File.join(@json_path, 'package.json'))
      @json_exists = true
    end
  end
end

action :install do
  action_install
end

def action_install

  unless @json_exists
    if npm_package_installed?
      Chef::Log.logger.info("#{new_resource} is already installed - nothing to do")
      return 
    end
    command = %{#{@npm_bin_path} --no-color install #{@registry_set} #{@install_flag_arg} #{@name} #{@options}}
    path = @path ? @path : ENV['HOME']
  else
    command = %{#{@npm_bin_path} --no-color install #{@registry_set} #{@options}}
    path = @json_path
  end

  nvm_script "#{command}" do
    code        command
    cwd         path if path
    action      :run
  end

  new_resource.updated_by_last_action(true)
end

def npm_package_installed?
  cwd = @path ? @path : ENV['HOME']
  command = %{. #{nvm_root}/nvm.sh && #{@npm_bin_path} --no-color ls #{@registry_set} #{@install_flag_arg} #{@name}}
  npm_shell_out(command, cwd)
end

