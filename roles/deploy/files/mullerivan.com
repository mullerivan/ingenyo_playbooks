# use the socket we configured in our unicorn.rb
upstream mullerivan_server {
  server unix:/tmp/mullerivan.socket
      fail_timeout=0;
  }

server {
	listen   80; ## listen for ipv4; this line is default and implied
	#listen   [::]:80 default ipv6only=on; ## listen for ipv6

	root /home/vagrant/mullerivan/public;
	index index.html index.htm;

	# Make site accessible from http://localhost/
	server_name mullerivan.com www.mullerivan.com;


    # maximum accepted body size of client request 
    client_max_body_size 4G;
    # the server will close connections after this time 
    keepalive_timeout 5;

    location / {
      try_files $uri @app;
    }

    location @app {
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header Host $http_host;
      proxy_redirect off;
      # pass to the upstream unicorn server mentioned above 
      # proxy_pass http://mullerivan_server;
      proxy_pass http://127.0.0.1:4020;
    }	
}
