limits-config:
  file.managed:
    - name: /etc/security/limits.conf
    - source: salt://init/files/limits.conf.template
    - user: root
    - group: root
    - mode: 644
