# Create a file holberton in /tmp/ with some characteristics
file { 'holberton':
  ensure  => 'present',
  path    => '/tmp/holberton',
  mode    => '0744',
  owner   => 'www-data',
  group   => 'www-data',
  content => 'I love Puppet'
}
