tty-ps1:
  file.append:
    - name: /etc/bashrc
    - text:
      - export PS1='[\u@\h \w]\$ '
