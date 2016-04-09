class deploy::dhcp( $domain_name ){

  class { 'dhcp':
    dnsdomain    => [
      $dmain_name
    ],
    interfaces   => ['enp11s0f0.40'],
    pxefilename  => 'bootstrap.ipxe',
  }    

  dhcp::pool{ "ceph.${domain_name}":
    network => '10.10.0.0',
	mask    => '255.255.255.0',
    domain_name => "ceph.$domain_name",
	range   => '10.10.0.0 10.10.0.100',
    nameservers  => ['10.10.0.252'],
    pxeserver    => '10.10.0.252',
  }

  dhcp::pool{ "hadoop.${domain_name}":
    network => '10.20.0.0',
	mask    => '255.255.255.0',
    domain_name => "hadoop.$domain_name",
	range   => '10.20.0.0 10.20.0.100',
    nameservers  => ['10.20.0.252'],
    pxeserver    => '10.20.0.252',
  }

  
}
