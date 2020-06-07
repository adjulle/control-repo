# == Class: profiles::puppetmaster
#

class profile::puppetmaster(
    Boolean $use_puppetdb,
    String $puppetdb_host,
) {

  class { 'puppet':
    server => true,
    config => {
      'java_args'     => {
        'xms'   => '512m',
        'xmx'   => '512m'
      }
    }
  }
  contain 'puppetserver'
  # Ensure server starts before agent to avoid key issues
  # Service['puppetserver']->Service['puppet']

  $confdir = $::settings::confdir
  file { "${confdir}/autosign.conf":
    ensure  => file,
    content => epp('profile/puppetmaster/autosign.conf.epp',{ 'autosign_hosts' => hiera('profiles::puppetmaster::autosign_hosts',[])}),
  }

  class { '::puppetserver::hiera::eyaml':
    require => Class['puppetserver::install'],
  }
  contain '::puppetserver::hiera::eyaml'

  if $use_puppetdb {

    class { 'puppetdb::master::config':
      puppetdb_server             => $puppetdb_host,
      manage_routes               => true,
      manage_storeconfigs         => true,
      manage_report_processor     => true,
      enable_reports              => true,
      strict_validation           => false,
      puppetdb_soft_write_failure => true
    }
    contain 'puppetdb::master::config'

  }
}
