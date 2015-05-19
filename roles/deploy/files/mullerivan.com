server {
    listen 80;
    server_name www.mullerivan.com mullerivan.com;
    root my_app/public;

    # You must explicitly set 'passenger_enabled on', otherwise
    # Phusion Passenger won't serve this app.
    passenger_enabled on;
}