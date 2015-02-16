# git repository
default['nvm']['git_url'] = 'https://github.com/creationix/nvm.git'
default['nvm']['git_ref'] = 'v0.19.0'

default['nvm']['root_path'] = '/usr/local/nvm'
default['nvm']['user'] = 'root'
default['nvm']['group'] = 'root'
default['nvm']['upgrade_flag'] = 'none'

case platform
when 'readhat', 'centos', 'fedora'
	default['nvm']['dependency_pkgs'] = %w{ libcurl curl openssl-devel gcc-c++ }
when 'debian','ubuntu'
	default['nvm']['dependency_pkgs'] = %w{ libcurl3 curl libssl-dev build-essential }
end
