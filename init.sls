{% import node from 'node/map.jinja' with context %}

node-deps:
  pkg.installed:
    - pkgs:
      - build-essential
      - curl

node-tarball:
  file.managed:
    - name: /usr/src/{{node.src_file}}.tar.gz
    - source: {{node.url}}
    - source_hash: {{node.url_hash}}
    - require:
      - pkg: node-deps
  cmd.wait:
    - cwd: /usr/src
    - name: tar zxf {{node.src_file}}.tar.gz
    - watch:
      - file: node-tarball

node-build:
  cmd.wait:
    - cwd: {{node.src_path}}
    - name: ./configure && make install
    - watch:
      - cmd: node-tarball