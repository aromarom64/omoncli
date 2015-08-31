module Omoncli

  require 'omoncli/omonbase'

  class Memory < Basesubcommand

    desc "buffer_cache", "buffer_cache"
    long_desc <<-LONGDESC
      Example: omoncli memory buffer_cache
    LONGDESC
    def buffer_cache
      r = Sqlpage.new('template/memory/buffer_cache.erb')
      vim(sqlplus(r))
    end

    desc "library_cache", "library_cache"
    long_desc <<-LONGDESC
      Example: omoncli memory library_cache
      If you see excessively high values in these columns, solutions include pinning packages
      in the shared pool using the KEEP procedure in the DBMS_SHARED_POOL package
    LONGDESC
    def library_cache
      r = Sqlpage.new('template/memory/library_cache.erb')
      vim(sqlplus(r))
    end

    desc "dictionary_cache", "dictionary_cache"
    long_desc <<-LONGDESC
      Example: omoncli memory dictionary_cache
    LONGDESC
    def dictionary_cache
      r = Sqlpage.new('template/memory/dictionary_cache.erb')
      vim(sqlplus(r))
    end

    desc "sga_dynamic_components", "sga_dynamic_components"
    long_desc <<-LONGDESC
      Example: omoncli memory sga_dynamic_components
    LONGDESC
    def sga_dynamic_components
      r = Sqlpage.new('template/memory/sga_dynamic_components.erb')
      vim(sqlplus(r))
    end

    desc "sga_target_advice", "sga_target_advice"
    long_desc <<-LONGDESC
      Example: omoncli memory sga_target_advice
    LONGDESC
    def sga_target_advice
      r = Sqlpage.new('template/memory/sga_target_advice.erb')
      vim(sqlplus(r))
    end

    desc "pga_target_advice", "pga_target_advice"
    long_desc <<-LONGDESC
      Example: omoncli memory pga_target_advice
    LONGDESC
    def pga_target_advice
      r = Sqlpage.new('template/memory/pga_target_advice.erb')
      vim(sqlplus(r))
    end

    desc "shared_pool_advice", "shared_pool_advice"
    long_desc <<-LONGDESC
      Example: omoncli memory shared_pool_advice
    LONGDESC
    def shared_pool_advice
      r = Sqlpage.new('template/memory/shared_pool_advice.erb')
      vim(sqlplus(r))
    end

    desc "sga_components", "sga_components"
    long_desc <<-LONGDESC
      Example: omoncli memory sga_components
    LONGDESC
    def sga_components
      r = Sqlpage.new('template/memory/sga_components.erb')
      vim(sqlplus(r))
    end

    desc "process_memory", "Display session memory usage from v$process_memory"
    long_desc <<-LONGDESC
      omoncli memory process_memory --value=123 or [--sid="spid"]
      Thanks http://blog.tanelpoder.com/files/scripts/pmem.sql
    LONGDESC
    option :sid, :type => :string, :default => 'sid', :enum => ['sid','spid']
    option :value, :type => :numeric, :required => true
    def process_memory
      Sqlpage.class_eval do
        attr_accessor :sid, :value
      end
      r = Sqlpage.new('template/memory/process_memory.erb')
      r.sid, r.value = options[:sid], options[:value]
      r._trim_mode = '-'
      vim(sqlplus(r))
    end

    desc "wrka", "Show Active workarea memory usage"
    long_desc <<-LONGDESC
      omoncli memory wrka --sid=123
      Thanks http://blog.tanelpoder.com/files/scripts/wrka.sql
    LONGDESC
    option :sid, :type => :numeric, :required => true
    def wrka
      Sqlpage.class_eval do
        attr_accessor :sid
      end
      r = Sqlpage.new('template/memory/wrka.erb')
      r.sid = options[:sid]
      vim(sqlplus(r))
    end

  end

end
