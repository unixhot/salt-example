include:
  - modules.nginx.service
  - modules.tomcat.service

web-bbs:
  file.managed:
    - name: /usr/local/nginx/conf/online/bbs.conf
    - source: salt://bbs/files/bbs-nginx.conf.template
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      IPADDR: {{ grains['fqdn_ip4'][0] }}
    - watch_in:
      - service: nginx-service
