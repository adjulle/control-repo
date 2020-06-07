# == Class: profile::puppetreports
#

class profile::puppetreports (
  String $puppetboard_vhost,
) {

  class { 'apache': }
  class { 'apache::mod::wsgi':
    wsgi_socket_prefix => '/var/run/wsgi',
  }
  class { 'puppetboard::apache::vhost':
    vhost_name => $puppetboard_vhost
  }

  $ssl_dir = $::settings::ssldir
  $puppetboard_certname = $clientcert

  class { 'puppetboard':
    groups              => 'puppet',
    manage_virtualenv   => true,
    puppetdb_host       => hiera('puppetdb_host'),
    puppetdb_port       => '8081',
    puppetdb_key        => "${ssl_dir}/private_keys/${puppetboard_certname}.pem",
    puppetdb_ssl_verify => false,
    puppetdb_cert       => "${ssl_dir}/certs/${puppetboard_certname}.pem",
  }

}
