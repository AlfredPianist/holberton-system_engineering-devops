# Script that installs and configures nginx on a server

# Update server
exec { 'update':
  command  => 'sudo apt update -y',
  provider => shell
}

# Install nginx
package { 'nginx':
  ensure  => 'installed',
  require => Exec['update']
}

# Create index file with content "Holberton School for the win!"
file { '/var/www/html/index.html':
  content => 'Holberton School for the win!',
  require => Package['nginx']
}

# Add custom header and permanent redirection
exec { 'modify-default':
  command  => 'sudo sed -i "/server_name _;/a \\\n\\tadd_header X-Served-By $HOSTNAME;"\
     		/etc/nginx/sites-available/default;
	       sudo sed -i "/add_header*/a \\\n\\trewrite ^/redirect_me https://example.com/ permanent;"\
     		/etc/nginx/sites-available/default;
	       sudo sed -i "/rewrite*/a \\\n\\terror_page 404 /404.html;\\n\\n\\tlocation = /404.html {\\n\\t\\tinternal;\\n\\t}"\
     		/etc/nginx/sites-available/default;',
  provider => shell,
  require  => Package['nginx']
}

# Run service nginx
service { 'nginx':
  ensure  => 'running',
  require => Exec['modify-default']
}
