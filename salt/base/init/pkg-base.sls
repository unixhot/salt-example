include:
  - init.yum-repo

base-install:
  pkg.installed:
    - pkgs:
      - screen
      - lrzsz
      - tree
      - openssl
      - telnet
      - iftop
      - iotop
      - sysstat
      - wget
      - dos2unix
      - lsof
      - net-tools
      - mtr
      - unzip
      - zip
      - vim-enhanced
      - bind-utils
    - require:
      - file: /etc/yum.repos.d/epel.repo
