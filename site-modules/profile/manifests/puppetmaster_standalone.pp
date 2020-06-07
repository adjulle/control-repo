# == Class: profiles::puppetmaster_standalone
#

class profile::puppetmaster_standalone(
  Boolean $use_puppetdb,
  Boolean $use_puppetboard,
  String  $puppetboard_vhost
) {

  apt::source { 'puppetlabs':
    location => 'http://apt.puppetlabs.com',
    repos    => 'main',
    key      => {
      id     => '47B320EB4C7C375AA9DAE1A01054B7A24BD6EC30',
      server => 'pgp.mit.edu'
    }
  }
  -> class { 'puppetserver':
    config => {
      'java_args'     => {
        'xms' => '512m',
        'xmx' => '512m'
      }
    }
  }

  class { '::puppetserver::hiera::eyaml':
    require => Class['puppetserver::install'],
  }

  if $use_puppetdb {
    class { 'puppetdb': }

    # No anchor in puppetdb module
    # We need ssl certificates to start jetty
    # puppdb ssl-setup is performed at package installaion and requires ssl certificates for the node
    Class['puppetserver'] -> Package['puppetdb']

    class { 'puppetdb::master::config':
      manage_routes           => true,
      manage_storeconfigs     => true,
      manage_report_processor => true,
      enable_reports          => true,
      strict_validation       => false
    }

    if $use_puppetboard {
      class { 'apache': }
      class { 'apache::mod::wsgi': }

      class { 'puppetboard':
        manage_virtualenv => 'latest'
      }

      class { 'puppetboard::apache::vhost':
        vhost_name => $puppetboard_vhost
      }
    }
  }

}
