include:
  - modules.nginx.install

nginx-init:
  file.managed:
    - name: /usr/lib/systemd/system/nginx.service
    - source: salt://modules/files/nginx-service.template
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: systemctl daemon-reload
    - require:
      - file: nginx-init

/usr/local/nginx/conf/nginx.conf:
  file.managed:
    - source: salt://modules/files/nginx.conf.template
    - user: www
    - group: www
    - mode: 644

nginx-service:
  file.directory:
    - name: /usr/local/nginx/conf/online
    - require:
      - cmd: nginx-install
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require:
      - cmd: nginx-init
    - watch:
      - file: /usr/local/nginx/conf/nginx.conf
      - file: nginx-service
