default[:redis_failover][:config][:max_failures] = 2
default[:redis_failover][:config][:node_strategy] = 'majority'
default[:redis_failover][:config][:failover_strategy] = 'latency'
default[:redis_failover][:config][:required_node_managers] = 2
default[:redis_failover][:config][:password] = nil
default[:redis_failover][:config][:nodes] = []
default[:redis_failover][:config][:zkservers] = []
