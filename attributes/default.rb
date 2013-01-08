default[:shorewall] = {
  :zones => [
    {:zone => "fw",  :type => "firewall"},
    {:zone => "net", :type => "ipv4"}
  ],
  :interfaces => [
    {:zone => 'net', :interface => "eth0", :broadcast => "detect", :options => "tcpflags,nosmurfs,logmartians"},
  ],
  :policy => [
    { :source => "fw",  :dest => "net", :policy => "ACCEPT" },
    { :source => "net", :dest => "all", :policy => "DROP",   :log => "info" },
    { :source => "all", :dest => "all", :policy => "REJECT", :log => "info" }
  ],
  :rules => [
    { :source => "net", :dest => "fw", :proto => "icmp", :action => "ACCEPT" },
    { :source => "net", :dest => "fw", :proto => "tcp", :dest_port => 22, :action => "ACCEPT" }
  ],
  :masq => [],
  :params => {},
  :enabled => true,
  :clamp_mss => false,
  :ip_forwarding => "Keep"
}
