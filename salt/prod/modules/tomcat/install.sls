{% set tomcat_version = "8.5.29" %}
include:
  - modules.jdk.install

tomcat-install:
  file.managed:
    - name: /usr/local/src/apache-tomcat-{{ tomcat_version }}.tar.gz
    - source: salt://modules/files/apache-tomcat-{{ tomcat_version }}.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf apache-tomcat-{{ tomcat_version }}.tar.gz && mv apache-tomcat-{{ tomcat_version }} /usr/local/ && ln -s /usr/local/apache-tomcat-{{ tomcat_version }} /usr/local/tomcat && chown -R www:www /usr/local/tomcat/ && chown -R www:www /usr/local/tomcat
    - unless: test -d /usr/local/apache-tomcat-{{ tomcat_version }} && test -L /usr/local/tomcat
    - require:
      - pkg: jdk-install
      - file: tomcat-install
