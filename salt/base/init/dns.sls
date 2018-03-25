/etc/resolv.conf:
  file.managed:
    - source: salt://init/files/resolv.conf.template
    - user: root
    - group: root
    - mode: 644
