# == Class: role::puppetmaster_standalone
#

class role::puppetmaster_standalone {

  include ::profile::base
  include ::profile::puppetmaster_standalone
  include ::profile::puppetagent

}
