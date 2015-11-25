# == Class: php::config
#
class nginx::config (
    $files = $::nginx::config_files,
) inherits nginx::params {

  if ( ! empty( $files ) ){
    info('Creating nginx configs')
    create_resources('::nginx::config::files', $files )
  }

}
