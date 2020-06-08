node 'puppetmaster.vm.local' {
  include role::puppetmaster_standalone
}

node 'puppetdb.vm.local' {
  include role::puppetdb
}

node 'puppetreports.vm.local' {
  include role::puppetreports
}

node 'default' {
  include role::agent
  notify { 'Unclassified node': }
}
