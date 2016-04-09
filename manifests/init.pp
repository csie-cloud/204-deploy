class creator{
  $domain_name = "cloudy.csie.ntu.edu.tw"
  include ::password
  include ::creator::razor   
  include ::creator::dns
  class{ '::creator::dhcp':
    domain_name => $domain_name
  }
}
