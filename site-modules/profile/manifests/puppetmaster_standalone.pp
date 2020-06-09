# == Class: profiles::puppetmaster_standalone
#

class profile::puppetmaster_standalone(
  Boolean $use_puppetdb,
  Boolean $use_puppetboard,
  Boolean $autosign,
  String  $puppetboard_vhost,
  String  $puppetdb_host,
) {

  include epel

  yumrepo { 'Foreman':
    ensure    => present,
    assumeyes => true,
    baseurl   => 'https://yum.theforeman.org/releases/2.1/el7/x86_64/',
    descr     => 'Foreman',
    enabled   => 1,
    gpgcheck  => 0,
  }

  class { 'foreman':  }

  # class { 'puppet':
  #   server              => true,
  #   server_ca           => true,
  #   server_reports      => 'puppetdb',
  #   server_storeconfigs => true,
  #   autosign            => $autosign,
  # }

  # class { 'puppet::server::puppetdb':
  #   server => $puppetdb_host,
  # }

  # if $use_puppetdb {
  #   class { 'puppetdb': }
  # }

}
