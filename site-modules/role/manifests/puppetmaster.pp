# == Class: role::puppetmaster
#

class role::puppetmaster {

  include profile::base
  include profile::puppetmaster
  include profile::puppetagent

  Class['profile::base'] -> Class['profile::puppetmaster'] -> Class['profile::puppetagent']

}
