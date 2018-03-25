/etc/yum.repos.d/epel.repo:
  file.managed:
    - source: salt://init/files/epel.repo.template
    - user: root
    - group: root
    - mode: 644
