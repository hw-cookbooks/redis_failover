# NOTE: This will search for zookeeper nodes built using the
# zookeeperd cookbook, optionally restricting to current env.

zk_search = 'zk_id:*'
if(node[:redis_failover][:zk_discovery][:common_environment])
  zk_search << " AND chef_environment:#{node.chef_environment}"
end

zk_nodes = search(:node, zk_search)
zk_node_info = zk_nodes.map do |zk_node|
  "#{zk_node[:ipaddress]}:#{zk_node[:zookeeperd][:config][:client_port]}"
end

node.default[:redis_failover][:config][:zkservers] = zk_node_info
