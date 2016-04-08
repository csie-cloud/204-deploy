class creator::razor{
  class { '::postgresql::server': }
  
  class { '::tftp':
    directory => '/var/lib/tftpboot',
    address   => 'localhost',
  }
  include 'wget'

  package{ 'puppetlabs-release':
    ensure => 'installed',
    source => 'http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm',
    provider => 'rpm'
  }

  notify{ 'tmp':
    message => "password: ${::password::keystone_db}"
  }
  
  class { 'razor':
    require => Package['puppetlabs-release'],
    database_hostname         => '127.0.0.1',
    database_password         => $::password::razor_db,
    compile_microkernel => false,
    enable_db => true,
    server_http_port => '8150',
  }
}
