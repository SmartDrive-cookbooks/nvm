#
# Cookbook Name:: nvm
# Provider:: script
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

use_inline_resources

include Chef::Nvm::ScriptHelpers

action :run do
  set_updated { run_script }
end

def run_script
  script_code              = build_script_code

  script new_resource.name do
    interpreter   "bash"
    code          script_code
    user          new_resource.user         if new_resource.user       
    creates       new_resource.creates      if new_resource.creates    
    cwd           new_resource.cwd          if new_resource.cwd        
    group         new_resource.group        if new_resource.group      
    path          new_resource.path         if new_resource.path       
    returns       new_resource.returns      if new_resource.returns       
    timeout       new_resource.timeout      if new_resource.timeout    
    umask         new_resource.umask        if new_resource.umask      
    environment   new_resource.environment  if new_resource.environment
  end
end

def build_script_code
  script = []
  script << %{source #{nvm_root}/nvm.sh}
  script << new_resource.code
  script.join("\n").concat("\n")
end
