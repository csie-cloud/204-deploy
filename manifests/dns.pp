class deploy::dns( $domain_name ){
  
  include bind
  
  bind::server::conf { '/etc/named.conf':
    listen_on_addr => ['127.0.0.1'],
    forwarders => [ '140.112.30.21', '8.8.8.8' ],
    allow_query => ['localnets'],
    views => {
      'hadoop' => {
        'match-clients' => [ '10.10.0.0/24' ],
        'zones' => {
          "${domain_name}" => [
            'type master',
            'file "hadoop.zone"'
          ]
        }
      },
      'ceph' => {
        'match-clients' => [ '10.20.0.0/24' ],
        'zones' => {
          "${domain_name}" => [
            'type master',
            'file "ceph.zone"'
          ]
        }
      },
      'hadoop' => {
        'match-clients' => [ '127.0.0.1/32' ],
        'zones' => {
          "${domain_name}" => [
            'type master',
            'file "hadoop.zone"'
          ]
        }
      },

    }
  }

  bind::server::file { 'hadoop.zone':
    content => epp('deploy/hadoop.zone.epp',
    { 'domain_name' => "hadoop.${domain_name}", 'ip_prefix' => '10.2.0' } )
  }

  bind::server::file { 'ceph.zone':
    content => epp('deploy/ceph.zone.epp',
    { 'domain_name' => "ceph.${domain_name}", 'ip_prefix' => '10.1.0' } )
  }
  
  Bind::Server::File { zonedir => '/var/named' }
  
  
}
