# documentation

define nginx::config::files (
  $ensure  = 'present',
  $content = '',
  $mode    = '0644',
){

  file { $name:
    ensure  => $ensure,
    content => $content,
    mode    => $mode,
  }

}
