#
# Cookbook Name:: nvm
# Resource:: npm
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

actions :install 

attribute :name,           :kind_of => String, :name_attribute => true
attribute :nodejs_version, :kind_of => String
attribute :version,        :kind_of => String
attribute :local_flag,     :kind_of => [TrueClass, FalseClass], :name_attribute => false
attribute :registry,       :kind_of => String
attribute :root_path,      :kind_of => String
attribute :path,           :kind_of => String
attribute :json_path,      :kind_of => String

def initialize(*args)
  super
  @action = :install
end
