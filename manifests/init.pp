# documentation
class nginx (
  $ensure          = $::nginx::params::ensure,
  $package_name    = $::nginx::params::package,
  $config_files    = $::nginx::params::config_files,
) inherits ::nginx::params {

  class { '::nginx::install':
    ensure   => $ensure,
  }

  class { '::nginx::config':
    files => $config_files,
  }

  case $ensure {
    'absent', 'purged': {
      $nginx_service_ensure = 'stopped'
      $nginx_service_enable = false
    }
    default: {
      $nginx_service_ensure = 'running'
      $nginx_service_enable = true
    }
  }

  service { 'nginx':
    ensure     => $nginx_service_ensure,
    enable     => $nginx_service_enable,
    hasrestart => true,
    hasstatus  => true,
    require    => Package[$package_name],
  }

  Class['::nginx::install'] ->
  Class['::nginx::config'] ->
  Service['nginx']

}
