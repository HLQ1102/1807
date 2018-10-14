#!/bin/bash
ssh-keygen 
ssh-copy-id 201.1.2.100
while inotifywait -rq /usr/local/nginx/html
do
    rsync -az /usr/local/nginx/html/ root@201.1.2.100:/usr/local/nginx/html/
done &
