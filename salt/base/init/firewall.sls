firewalld-stop:
  service.dead:
    - name: firewalld.service
    - enable: False
