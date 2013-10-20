{% from 'node/map.jinja' import nodejs with context %}
nodejs-binary:
  cmd.run:
    - cwd: {{nodejs.src_path}}
    - name: make uninstall

nodejs-src:
  file.absent:
    - name: {{nodejs.src_path}}
    - require:
      - cmd: nodejs-binary

nodejs-tarball:
  file.absent:
    - name: {{nodejs.src_path}}.tar.gz