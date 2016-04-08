class creator::dhcp{
    class{ 'dhcp':
	interfaces => ['enp11s0f0.40']
    }

    

    dhcp::pool{ 'ops.dc1.example.net':
        network => '192.168.0.0',
	mask    => '255.255.0.0',
	range   => '192.168.215.0 192.168.215.100',
    }

}
