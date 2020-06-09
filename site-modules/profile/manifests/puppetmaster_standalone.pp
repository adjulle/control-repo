# == Class: profiles::puppetmaster_standalone
#

class profile::puppetmaster_standalone(
  Boolean $use_puppetdb,
  Boolean $use_puppetboard,
  Boolean $autosign,
  String  $puppetboard_vhost,
  String  $puppetdb_host,
) {

  class { 'puppet':
    server              => true,
    server_reports      => 'puppetdb,foreman',
    server_storeconfigs => true,
    autosign            => $autosign,
  }

  class { 'puppet::server::puppetdb':
    server => $puppetdb_host,
  }

  if $use_puppetdb {
    class { 'puppetdb': }
  }

}
