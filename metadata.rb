name             'nvm'
maintainer       'Yuki Osawa'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures nvm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

%w{centos ubuntu}.each do |os|
  supports os
end
depends 'git'
