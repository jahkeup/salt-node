{% from 'node/map.jinja' import node with context %}
node-binary:
  cmd.run:
    - cwd: {{node.src_pa
    th}}
    - name: make uninstall

node-src:
  file.absent:
    - name: {{node.src_path}}
    - require:
      - cmd: node-binary

node-tarball:
  file.absent:
    - name: {{node.src_path}}.tar.gz