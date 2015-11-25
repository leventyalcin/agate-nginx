# == Class: nginx::install
#
class nginx::install (
  $ensure   = $::nginx::ensure,
  $package  = $::nginx::package_name,

)
{

  case $ensure {
    'absent', 'purged': {
      $nginx_repo_enabled = '0'
    }
    default: {
      $nginx_repo_enabled = '1'
    }
  }
  yumrepo { 'nginx':
    baseurl  => 'http://nginx.org/packages/centos/$releasever/$basearch/',
    descr    => 'nginx repo',
    enabled  =>  $nginx_repo_enabled,
    gpgcheck => '0',
  }

  package { $package:
    ensure  => $ensure,
    require => Yumrepo['nginx'],
  }

}
