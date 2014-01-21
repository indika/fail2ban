#!/bin/bash


fail2ban-regex /var/log/nginx/access.log /etc/fail2ban/filter.d/nginx-auth.conf
fail2ban-regex /var/log/nginx/access.log /etc/fail2ban/filter.d/nginx-login.conf
fail2ban-regex /var/log/nginx/access.log /etc/fail2ban/filter.d/nginx-noscript.conf
fail2ban-regex /var/log/nginx/access.log /etc/fail2ban/filter.d/nginx-proxy.conf
fail2ban-regex /var/log/nginx/access.log /etc/fail2ban/filter.d/w00tw00t.conf
fail2ban-regex /var/log/nginx/access.log /etc/fail2ban/filter.d/apache-badbots.conf
