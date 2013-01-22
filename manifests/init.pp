# == Class: sudo
#
# Full description of class sudo here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { sudo:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
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
#          nopasswd: fals
class sudo (
  $config = undef,
) {
  if $config {
    $filenames = keys($config)
    sudo::file { $filenames:
      config => $config,
    }
  }
  else {
    $hiera_config = hiera_hash('sudo::rules', undef)
    if $hiera_config {
      $filenames = keys($hiera_config)
      sudo::file { $filenames:
        config => $hiera_config,
      }
    }
  } 
}
