# == Class: profiles::base
#

class profile::base (
  String $message,
) {

  include common::packages::install
  notify { 'Message':
    name => $message,
  }

}
