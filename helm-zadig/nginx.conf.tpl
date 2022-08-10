server {
    listen CHANGE_BY_YOURSELF ssl;
    server_name CHANGE_BY_YOURSELF;

    access_log /var/log/zadig-access.log main;
    error_log /var/log/zadig-error.log;

    ssl_certificate CHANGE_BY_YOURSELF;
    ssl_certificate_key CHANGE_BY_YOURSELF;

    location / {
        proxy_set_header Host "CHANGE_BY_YOURSELF";
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_http_version 1.1;
        proxy_set_header Upgrade "websocket";
        proxy_set_header Connection "Upgrade";

        proxy_pass http://CHANGE_BY_YOURSELF:31110;
    }

}
