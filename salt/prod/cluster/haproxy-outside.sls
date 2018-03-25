include:
  - modules.haproxy.install

haproxy-service:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://cluster/files/haproxy-outside.cfg.template
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: haproxy
    - enable: True
    - reload: True
    - require:
      - cmd: haproxy-install
    - watch:
      - file: haproxy-service
