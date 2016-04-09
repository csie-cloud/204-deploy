class deploy{
  $domain_name = "204.csie.ntu.edu.tw"
  include ::deploy::razor   
  
  class{ '::deploy::dns':
    domain_name => $domain_name
  }

  class{ '::deploy::dhcp':
    domain_name => $domain_name
  }
}
