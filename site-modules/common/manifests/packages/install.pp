# == Class: packages::install
#

class common::packages::install (
  Hash $packages,
) {

  if ( $packages ) {
    create_resources( package, $packages )
  }

}
