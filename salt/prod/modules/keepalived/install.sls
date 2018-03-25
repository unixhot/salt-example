{% set keepalived_version="keepalived-1.4.2" %}

include:
  - modules.pkg.make

keepalived-install:
  file.managed:
    - name: /usr/local/src/{{ keepalived_version }}.tar.gz
    - source: salt://modules/files/{{ keepalived_version }}.tar.gz
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: cd /usr/local/src && tar zxf {{ keepalived_version }}.tar.gz && cd {{ keepalived_version }} && ./configure --prefix=/usr/local/keepalived --disable-fwmark && make && make install
    - unless: test -d /usr/local/keepalived
    - require:
      - file: keepalived-install

/usr/lib/systemd/system/keepalived.service:
  file.managed:
    - source: salt://modules/files/keepalived.service.template
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: systemctl daemon-reload

/etc/keepalived:
  file.directory:
    - user: root
    - group: root

