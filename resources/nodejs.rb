#
# Cookbook Name:: nvm
# Resource:: nodejs
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

actions :install

attribute :version, :kind_of => String, :name_attribute => true
attribute :from_source_flag, :kind_of => [TrueClass, FalseClass], :name_attribute => false
attribute :root_path, :kind_of => String
attribute :alias_default_flag, :kind_of => [TrueClass, FalseClass], :name_attribute => false

def initialize(*args)
  super
  @action = :install
end
