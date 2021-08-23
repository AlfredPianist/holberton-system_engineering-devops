# Script that installs and configures nginx on a server

# Install nginx
exec { 'nginx':
  command  => 'sudo apt update &&
	      sudo apt install nginx -y',
  provider => shell
}

# Create index file with content "Holberton School for the win!"
file { '/var/www/html/index.html':
  content => 'Holberton School for the win!',
  require => Exec['nginx']
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
  require  => Exec['nginx']
}

# Run service nginx
service { 'nginx':
  ensure  => 'running',
  require => Exec['modify-default']
}
