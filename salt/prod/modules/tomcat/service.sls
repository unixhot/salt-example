include:
  - modules.tomcat.install

tomcat-init:
  file.managed:
    - name: /usr/lib/systemd/system/tomcat.service
    - source: salt://modules/files/tomcat-service.template
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: systemctl daemon-reload
    - unless: test -f /lib/systemd/system/tomcat.service
    - require:
      - file: tomcat-init

/usr/local/tomcat/conf/server.xml:
  file.managed:
    - source: salt://modules/files/tomcat.conf.template
    - user: www
    - group: www
    - mode: 644 

tomcat-service:
  service.running:
    - name: tomcat
    - enable: True
    - reload: True
    - require:
      - cmd: tomcat-init
    - watch:
      - file: /usr/local/tomcat/conf/server.xml

