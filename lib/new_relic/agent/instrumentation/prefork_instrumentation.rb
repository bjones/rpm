if defined?(PreFork::Server)
  NewRelic::Control.instance.log.debug "Installing PreFork event hooks."

  class PreFork::Server
    def new_relic_start_child(slot, socket)
      NewRelic::Agent.instance.stats_engine.reset_stats
      orig_start_child(slot, socket)
    end
    alias_method :orig_start_child, :start_child
    alias_method :start_child, :new_relic_start_child
  end
end 
