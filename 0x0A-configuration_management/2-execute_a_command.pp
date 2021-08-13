# Creates a manifest to kill process named 'killmenow'
exec { 'kill_me_now':
  path    => '/usr/bin/',
  command => 'pkill -f killmenow'
}
