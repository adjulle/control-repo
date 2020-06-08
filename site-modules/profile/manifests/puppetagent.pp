# == Class: profiles::puppetagent
#

class profile::puppetagent(
    String $puppetmaster,
) {

  filebucket { 'puppetmaster':
    path  => false,
  }

  File {
    # All file resources will be backed up
    backup  => 'puppetmaster',
  }

  ini_setting { 'Puppet server':
    ensure    => present,
    path      => '/etc/puppetlabs/puppet/puppet.conf',
    section   => 'agent',
    setting   => 'server',
    value     => $puppetmaster,
    show_diff => true
  }

  # service { 'puppet':
  #   ensure => running,
  #   enable => true
  # }

}
