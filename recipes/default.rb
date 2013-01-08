package 'shorewall' do
  action :install
end

template "/etc/default/shorewall" do
  source "default/shorewall"
  variables :startup => (node[:shorewall][:enabled] ? 1 : 0)
  owner "root"
  group "root"
  mode  0644
end

template "/etc/shorewall/shorewall.conf" do
  source "shorewall.conf"
  owner "root"
  group "root"
  mode  0644
  notifies :restart, 'service[shorewall]'
end

%w(zones interfaces policy rules masq params).each do |configuration_file|
  unless node[:shorewall][configuration_file].empty?
    template "/etc/shorewall/#{configuration_file}" do
      source configuration_file
      owner "root"
      group "root"
      mode  0644
      notifies :restart, 'service[shorewall]'
    end
  end
end

service 'shorewall' do
  supports :restart => true
  action [:enable, :start]
end
