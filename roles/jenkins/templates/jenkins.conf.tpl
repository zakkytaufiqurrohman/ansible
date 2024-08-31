server {
    listen 80;
    listen [::]:80;
    server_name xxxx;

    location / {
        return 301 https://$host$request_uri;
    }
}
server {
    listen 443 ssl;
    server_name xxxx;

    ssl_protocols TLSv1.2 TLSv1.3;

    ssl_certificate "/etc/letsencrypt/live/xxxx/fullchain.pem";
    ssl_certificate_key "/etc/letsencrypt/live/xxxx/privkey.pem";

    location / {
        proxy_pass http://jenkins:8080;
        proxy_buffering         off;
        proxy_redirect          off;
        proxy_set_header        Host            $host;
        proxy_set_header        X-Real-IP       $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        Referer         $http_referer;
    }
}
