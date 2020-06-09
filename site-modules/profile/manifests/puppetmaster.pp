# == Class: profiles::puppetmaster
#

class profile::puppetmaster(
    Boolean $use_puppetdb,
    Boolean $autosign,
    String  $puppetdb_host,
) {

  if $use_puppetdb {

    class { 'puppet':
      server              => true,
      server_foreman      => false,
      server_reports      => 'puppetdb',
      server_storeconfigs => true,
      autosign            => $autosign,
    }

    class { 'puppet::server::puppetdb':
      server => $puppetdb_host,
    }

  }
  else {
    class { '::puppet':
      server         => true,
      server_foreman => false,
      server_reports => 'store',
      autosign       => $autosign,
    }
  }
}
