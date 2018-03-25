close_selinux:
  file.managed:
    - name: /etc/selinux/config
    - source: salt://init/files/selinux-config.template
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: setenforce 0 || echo ok
    - onlyif: getsebool
