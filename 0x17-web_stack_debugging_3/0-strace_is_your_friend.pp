# Fixes typo phpp

file_line { 'fix phpp':
  ensure => 'present',
  path   => '/var/www/html/wp-settings.php',
  line   => 'require_once( ABSPATH . WPINC . \'/class-wp-locale.php\' );',
  match  => 'phpp'
}
