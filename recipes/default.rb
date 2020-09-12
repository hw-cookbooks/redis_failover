gem_package 'redis_failover'

if node['redis_failover']['zk_discovery']['enabled']
  include_recipe 'redis_failover::zk_discovery'
end

if node['redis_failover']['redis_discovery']['enabled']
  include_recipe 'redis_failover::redis_discovery'
end

directory '/etc/redis_failover' do
  mode '755'
end

template '/etc/redis_failover/config.yml' do
  source 'config.yml.erb'
  mode '644'
  notifies :restart, 'service[redis_node_manager]'
end

unless node['redis_failover']['ruby_bin_dir']
  node.default['redis_failover'][:ruby_bin_dir] = node.languages.ruby.bin_dir ||
                                                  File.dirname(RbConfig.ruby)
end

template '/etc/init.d/redis_node_manager' do
  source 'redis_node_manager.erb'
  mode '755'
  variables(
    start_script: 'redis_node_manager -c /etc/redis_failover/config.yml',
    user: node['redis_failover']['process_owner']
  )
end

service 'redis_node_manager' do
  action [:enable, :start]
end
