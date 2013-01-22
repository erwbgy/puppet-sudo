#sudo::rules:
#  /etc/sudoers:
#    - users:
#        - %users
#        - %ops
#      hosts:
#        - fs1
#        - fs2
#      commands:
#        /apps/tomcat/restart.sh:
#          runas_user: tomcat
#          nopasswd: true
#        /apps/tomcat/start.sh:
#          runas_user: tomcat
#          nopasswd: false
#    - users:
#        - root
#        - %sysadmins
#        - wheel
#      commands:
#        ALL:
#          runas_user: root
#          nopasswd: false
#
#  /etc/sudoers-1:
#    users:
#    hosts:
#    commands:

define sudo::file (
  $config,
) {
  $filename = $title
  $entries = $config[$filename]
  $n = range(1, size($entries))
  $p = prefix($n, "${filename}-")
  $z = zip($entries, $p)
  $f = flatten($z)
  $h = hash($f)
  create_resources('sudo::entry', $h)
}
