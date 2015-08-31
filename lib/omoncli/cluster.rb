module Omoncli

  require 'omoncli/omonbase'

  class Cluster < Basesubcommand

    desc "segment_stat", "segment_stat"
    long_desc <<-LONGDESC
      gv$iofuncmetric
      Example: omoncli cluster segment_stat
    LONGDESC
    option :schema, :default => 'TOPGAME5', :type => :string
    def segment_stat
      Sqlpage.class_eval do
        attr_accessor :schema
      end
      r = Sqlpage.new('template/cluster/segment_stat.erb')
      r.schema = options[:schema]
      vim(sqlplus(r))
    end

    desc "average_latency", "average_latency"
    long_desc <<-LONGDESC
      gv$sysstat
      Example: omoncli cluster segment_stat
    LONGDESC
    def average_latency
      r = Sqlpage.new('template/cluster/average_latency.erb')
      vim(sqlplus(r))
    end

    desc "average_lms", "average_lms"
    long_desc <<-LONGDESC
      gv$sysstat
      Example: omoncli cluster average_lms
    LONGDESC
    def average_lms
      r = Sqlpage.new('template/cluster/average_lms.erb')
      vim(sqlplus(r))
    end

    desc "current_block_activity", "current_block_activity"
    long_desc <<-LONGDESC
      gv$sysstat
      Example: omoncli cluster current_block_activity
    LONGDESC
    def current_block_activity
      r = Sqlpage.new('template/cluster/current_block_activity.erb')
      vim(sqlplus(r))
    end

    desc "current_block_activity_lms", "current_block_activity_lms"
    long_desc <<-LONGDESC
      gv$sysstat
      Example: omoncli cluster current_block_activity_lms
    LONGDESC
    def current_block_activity_lms
      r = Sqlpage.new('template/cluster/current_block_activity_lms.erb')
      vim(sqlplus(r))
    end

    desc "blocking_sessions", "blocking_sessions"
    long_desc <<-LONGDESC
      Example: omoncli cluster blocking_sessions
    LONGDESC
    def blocking_sessions
      r = Sqlpage.new('template/cluster/blocking_sessions.erb')
      vim(sqlplus(r))
    end

    desc "global_enqueue_service", "global_enqueue_service"
    long_desc <<-LONGDESC
      Example: omoncli cluster global_enqueue_service
    LONGDESC
    def global_enqueue_service
      r = Sqlpage.new('template/cluster/global_enqueue_service.erb')
      vim(sqlplus(r))
    end

    desc "lock_conversions", "lock_conversions"
    long_desc <<-LONGDESC
      Example: omoncli cluster lock_conversions
    LONGDESC
    def lock_conversions
      r = Sqlpage.new('template/cluster/lock_conversions.erb')
      vim(sqlplus(r))
    end

  end

end
