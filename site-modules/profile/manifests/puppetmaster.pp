# == Class: profiles::puppetmaster
#

class profile::puppetmaster(
    Boolean $use_puppetdb,
    Boolean $autosign,
    String  $puppetdb_host,
) {

  # Ensure server starts before agent to avoid key issues
  # Service['puppetserver']->Service['puppet']

  $confdir = $::settings::confdir
  file { "${confdir}/autosign.conf":
    ensure  => file,
    content => epp('profile/puppetmaster/autosign.conf.epp',{ 'autosign_hosts' => $autosign_hosts }),
  }

  # class { '::puppetserver::hiera::eyaml':
  #   require => Class['puppetserver::install'],
  # }
  # contain '::puppetserver::hiera::eyaml'

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

    # class { 'puppetdb::master::config':
    #   puppetdb_server             => $puppetdb_host,
    #   manage_routes               => true,
    #   manage_storeconfigs         => true,
    #   manage_report_processor     => true,
    #   enable_reports              => true,
    #   strict_validation           => false,
    #   puppetdb_soft_write_failure => true
    # }
    # contain 'puppetdb::master::config'

  }
  else {
    class { '::puppet':
      server                => true,
      server_foreman        => false,
      server_reports        => 'store',
      server_external_nodes => '',
      autosign              => $autosign,
    }
  }
}
