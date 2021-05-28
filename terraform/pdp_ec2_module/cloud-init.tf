data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = <<-EOF
      package_update: true
      packages:
        - docker.io
        - docker-compose
      groups:
        - docker
      users:
        - default
        - name: ubuntu
          groups: docker
      write_files:
        - path: /opt/pdp/pdp-env
          encoding: b64
          content: ${base64encode(data.template_file.docker_env.rendered)}
          owner: root:root
          permissions: '0644'
      runcmd:
        - [docker, run, -d, --restart, always, -p, 80:8181, --env-file, /opt/pdp/pdp-env, buildsecurity/pdp]
    EOF
  }
}
