#!/usr/bin/env bash

#docker build -t walt3rl/proton-privoxy:0.4.2-dev ../..
docker-compose up -d
pvpnpass=$(docker-compose exec proton-privoxy cat /root/.pvpn-cli/pvpnpass)
docker-compose down

username=$(echo "$pvpnpass" | head -n 1 | sed 's/\s*$//g')
password=$(echo "$pvpnpass" | tail -n 1 | sed 's/\s*$//g')
errcode=0

if [ "$username" == "$(cat creds/username)" ]; then
    echo "✅ Username is correct"
else
    echo "❌ Username does NOT match creds/username: $username"
    command -v xxd &> /dev/null && echo "$username" | xxd
    errcode=1
fi

if [ "$password" == "$(cat creds/password)" ]; then
    echo "✅ Password is correct"
else
    echo "❌ Password does NOT match creds/password: $password"
    command -v xxd &> /dev/null && echo "$password" | xxd
    errcode=1
fi

exit $errcode
