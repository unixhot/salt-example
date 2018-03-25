base:
  '*':
    - init.init-all

prod:
  'linux-node1.example.com':
    - redis-cluster.master
    - bbs.bbs-nginx
    - cluster.haproxy-outside
    - cluster.keepalived-outside
  'linux-node2.example.com':
    - redis-cluster.slave
    - bbs.bbs-nginx
    - cluster.haproxy-outside
    - cluster.keepalived-outside
