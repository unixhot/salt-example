{% set haproxy_version = "1.8.4" %}

include:
  - modules.pkg.make

haproxy-install:
  file.managed:
    - name: /usr/local/src/haproxy-{{ haproxy_version }}.tar.gz
    - source: salt://modules/files/haproxy-{{ haproxy_version }}.tar.gz
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: cd /usr/local/src && tar zxf haproxy-{{ haproxy_version }}.tar.gz && cd haproxy-{{ haproxy_version }} && make TARGET=linux26 PREFIX=/usr/local/haproxy && make install PREFIX=/usr/local/haproxy
    - unless: test -d /usr/local/haproxy
    - require:
      - pkg: pkg-init
      - file: haproxy-install

/etc/init.d/haproxy:
  file.managed:
    - source: salt://modules/files/haproxy.init.template
    - mode: 755
    - user: root
    - group: root

haproxy-config-dir:
  file.directory:
    - name: /etc/haproxy
    - mode: 755
    - user: root
    - group: root

net.ipv4.ip_nonlocal_bind:
  sysctl.present:
    - value: 1

