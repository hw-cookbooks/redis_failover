# NOTE: This will search for redis nodes built using the
# hw forked redis cookbook, optionally restricting to current env.

redis_search = 'recipes:redis\:\:server'
if node['redis_failover']['redis_discovery']['common_environment']
  redis_search << " AND chef_environment:#{node.chef_environment}"
end

redis_nodes = search(:node, redis_search)
redis_node_info = redis_nodes.map do |redis_node|
  "#{redis_node[:ipaddress]}:#{redis_node[:redis][:config][:port]}"
end

self_redis = "#{node['ipaddress']}:#{node['redis']['config']['port']}"

unless redis_node_info.include?(self_redis)
  redis_node_info.push(self_redis)
end

node.default['redis_failover']['config'][:nodes] = redis_node_info
