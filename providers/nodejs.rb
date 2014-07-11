#
# Cookbook Name:: nvm
# Provider:: nvm_nodejs
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

include Chef::Nvm::ScriptHelpers

def load_current_resource
  @version = new_resource.version
  @from_source_flag = new_resource.from_source_flag
  @root_path = new_resource.root_path
  @alias_default_flag  = new_resource.alias_default_flag
end

action :install do
  action_install
end

def action_install
  version = @version
  alias_default_flag  = @alias_default_flag
  from_source_arg = @from_source_flag ? '-s' : ''

  if nodejs_installed?
    Chef::Log.debug("#{new_resource} is already installed - nothing to do")
  else
    command = %[nvm install #{from_source_arg} #{version}]

    nvm_script "#{command}" do
      code        command
      version     version
      root_path   nvm_root
      action      :nothing
    end.run_action(:run)
  end

  nvm_alias_default version do
    action :create
    only_if { alias_default_flag }
  end

  new_resource.updated_by_last_action(true)
end

def nodejs_installed?
  ::File.directory?(::File.join(nvm_root, @version))
end
