#
# Cookbook Name:: nvm
# Resource:: alias_default
#
# Copyright 2014, Yuki Osawa
#
# All rights reserved - Do Not Redistribute
#

actions :create

attribute :version, :kind_of => String, :name_attribute => true
attribute :root_path, :kind_of => String

def initialize(*args)
  super
  @action = :create
end
