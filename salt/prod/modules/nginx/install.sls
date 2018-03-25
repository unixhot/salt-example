{% set nginx_version = "1.12.2" %}
include:
  - modules.pkg.make

nginx-install:
  file.managed:
    - name: /usr/local/src/nginx-{{ nginx_version }}.tar.gz
    - source: salt://modules/files/nginx-{{ nginx_version }}.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src && tar zxf nginx-{{ nginx_version }}.tar.gz && cd nginx-{{ nginx_version }} && ./configure --prefix=/usr/local/nginx-{{ nginx_version }} --user=www --group=www --with-http_ssl_module --with-stream --with-http_stub_status_module --with-file-aio && make && make install && ln -s /usr/local/nginx-{{ nginx_version }} /usr/local/nginx
    - unless: test -d /usr/local/nginx-{{ nginx_version }} && test -L /usr/local/nginx
    - require:
      - file: nginx-install
      - pkg: pkg-init
