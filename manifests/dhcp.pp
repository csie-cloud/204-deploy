class creator::dhcp( $domain_name ){

  class { 'dhcp':
    dnsdomain    => [
      $dmain_name
    ],
    nameservers  => ['192.168.217.254'],
    interfaces   => ['enp11s0f0.40'],
    pxeserver    => '192.168.217.254',
    pxefilename  => 'bootstrap.ipxe',
  }    

  dhcp::pool{ 'ops.dc1.example.net':
    network => '192.168.0.0',
	mask    => '255.255.0.0',
    domain_name => $domain_name,
	range   => '192.168.215.0 192.168.215.100',
  }

}
