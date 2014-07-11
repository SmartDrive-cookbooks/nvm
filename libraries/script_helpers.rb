#
# Cookbook Name:: nvm
# Library:: Chef::Nvm::Helpers
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

require 'chef'
include Chef::Mixin::ShellOut

class Chef
  module Nvm
    module ScriptHelpers
      def nvm_root
        if new_resource.root_path
          new_resource.root_path
        else
          node['nvm']['root_path']
        end
      end

      def current_default_version
        version_file = ::File.join(nvm_root, 'alias/default')
        ::File.exists?(version_file) && ::IO.read(version_file).chomp
      end

      def npm_shell_out(command, cwd)
        exit_code = true
        p = shell_out(command, :cwd => cwd)
        #if p.stderr.split("\n").last =~ /^npm ERR.+/i
        if p.stdout.include?("empty")
          exit_code = false
        end
        exit_code
      end

      def set_updated
        r = yield
        new_resource.updated_by_last_action(r.updated_by_last_action?)
      end
    end
  end
end
