# Script that modifies the open file descriptor limit for nginx

service {'nginx':
  ensure => 'running',
  enable => true
}

exec { 'fix ulimit':
  notify   => Service['nginx'],
  command  => 'sed -i "5 s/[[:digit:]]\{1,\}/$(ulimit -Hn)/" /etc/default/nginx',
  provider => 'shell'
}
