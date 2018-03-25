mysql-user-group:
  group.present:
    - name: mysql
    - gid: 1001
  user.present:
    - name: mysql
    - fullname: mysql
    - shell: /sbin/bash
    - uid: 1001
    - gid: 1001

mysql-install:
  file.managed:
    - name: /usr/local/src/{{ mysql_version }}.tar.gz
    - source: salt://modules/files/{{ mysql_version }}.tar.gz
    - user: mysql
    - group: mysql
    - mode: 755
    - require:
      - user: mysql-user-group
  cmd.run:
    - name: cd /usr/local/src && tar zxf {{ mysql_version }}.tar.gz && mv {{ mysql_version }} /usr/local/ && chown -R mysql:mysql /usr/local/{{ mysql_version }} && ln -s /usr/local/{{ mysql_version }} /usr/local/mysql && chown -R mysql:mysql /usr/local/mysql
    - unless: test -d /usr/local/{{ mysql_version }} && test -L /usr/local/mysql
    - require:
      - file: mysql-install

