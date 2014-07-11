#
# Cookbook Name:: nvm
# Provider:: nvm_alias_default
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

include Chef::Nvm::ScriptHelpers

use_inline_resources

action :create do
  if current_default_version_correct?
    set_updated { run_script }
  else
    Chef::Log.debug("#{new_resource} is already set - nothing to do")
  end
end

def run_script
  command = %{nvm alias default #{new_resource.version}}

  nvm_script "#{command}" do
    code        command
    version     new_resource.version
    root_path   new_resource.root_path if new_resource.root_path
    action      :run
  end
end

def current_default_version_correct?
  current_default_version != new_resource.version
end

