#
# Cookbook Name:: nvm
# Library:: Chef::Nvm::Helpers
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

class Chef
  module Nvm
    module RecipeHelpers
      def initialize_nvm(opts)
        prefix = opts[:root_path]

        bash "Initialize nvm" do
          code    "source #{prefix}/nvm.sh"
          user    opts[:user] if opts[:user]
          group   opts[:group] if opts[:group]
        end
      end

      def git_deploy_nvm(opts)
        if opts[:upgrade_flag] == "none"
          git_exec = :checkout
        else
          git_exec = :sync
        end

        git opts[:root_path] do
          repository  opts[:git_url]
          reference   opts[:git_ref]
          user        opts[:user] if opts[:user]
          group       opts[:group] if opts[:group]
          action       git_exec
        end
      end 

      def install_or_upgrade_nvm(opts ={})
        git_deploy_nvm opts
        initialize_nvm opts
      end
    end
  end
end
