module ChefRedisFailover
  class << self
    def symbolized_hash(hsh)
      new_hsh = {}
      hsh.each do |k,v|
        new_hsh[k.to_sym] = v.is_a?(Hash) ? symbolized_hash(v) : v
      end
      new_hsh
    end
  end
end
