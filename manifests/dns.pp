class creator::dns{
  $domain_name = 'cloudy.csie.ntu.edu.tw'
  include dns::server

  dns::server::options { '/etc/named/named.conf.options':
    listen_on => ['127.0.0.1'],
    forwarders => [ '140.112.30.21', '8.8.8.8' ]
  }
  
  dns::zone { $domain_name:
    soa => "na.${domain_name}",
    nameservers => ['ns'],
  }
  
  dns::zone { '217.168.192.IN-ADDR.ARPA':
    soa => "ns.${domain_name}",
    nameservers => ['ns'],
  }

  dns::record::ns {
    "${domain_name}":
      zone => $domain_name,
      data => 'ns'
  }
  
  dns::record::a {
    'creator':
      zone => $domain_name,
      data => ['192.168.217.254'],
      ptr => true;
    'controller1':
      zone => $domain_name,
      data => ['192.168.217.241'],
      ptr => true;
    'compute1':
      zone => $domain_name,
      data => ['192.168.217.201'],
      ptr => true;
  }

  dns::record::cname {
    'controller':
      zone => $domain_name,
      data => "controller1.${dmain_name}";
    'storage':
      zone => $domain_name,
      data => "storage1.${dmain_name}";
  }
  
}
