module Omoncli

  require 'omoncli/omonbase'

  class Stat < Basesubcommand

    desc "iostat", "iostat"
    long_desc <<-LONGDESC
      gv$iofuncmetric
      Example: omoncli stat iostat
    LONGDESC
    def iostat
      r = Sqlpage.new('template/stat/iostat.erb')
      vim(sqlplus(r))
    end

    desc "hist_sqlstat", "hist_sqlstat"
    long_desc <<-LONGDESC
      omoncli stat hist_sqlstat --sql_id="" --bdate="#{DateTime.now.strftime('%d-%m-%Y %H:00:00')}" --edate="#{DateTime.now.strftime('%d-%m-%Y %H:00:00')}"
    LONGDESC
    option :sql_id, :required => true, :type => :string
    option :bdate, :required => true, :type => :string
    option :edate, :required => true, :type => :string
    def hist_sqlstat
      Sqlpage.class_eval do
        attr_accessor :sql_id, :bdate, :edate
      end
      r = Sqlpage.new('template/stat/hist_sqlstat.erb')
      r.sql_id, r.bdate, r.edate = options[:sql_id], options[:bdate], options[:edate]
      vim(sqlplus(r))
    end

    desc "sysmetric", "sysmetric"
    long_desc <<-LONGDESC
      gv$sysmetric
      Example: omoncli stat sysmetric
    LONGDESC
    option :metric, :type => :string, :default => 'throughput', :enum => ['throughput','all']
    def sysmetric
      Sqlpage.class_eval do
        attr_accessor :metric
      end
      r = Sqlpage.new('template/stat/sysmetric.erb')
      r.metric = options[:metric]
      vim(sqlplus(r))
    end

    desc "servicemetric", "servicemetric"
    long_desc <<-LONGDESC
      gv$servicemetric gvsm
      Example: omoncli stat servicemetric
    LONGDESC
    def servicemetric
      r = Sqlpage.new('template/stat/servicemetric.erb')
      vim(sqlplus(r))
    end

    desc "rsrcmgrmetric", "rsrcmgrmetric"
    long_desc <<-LONGDESC
      gv$rsrcmgrmetric
      Example: omoncli stat rsrcmgrmetric
    LONGDESC
    def rsrcmgrmetric
      r = Sqlpage.new('template/stat/rsrcmgrmetric.erb')
      vim(sqlplus(r))
    end

    desc "resource_limit", "resource_limit"
    long_desc <<-LONGDESC
      gv$resource_limit
      Example: omoncli stat resource_limit
    LONGDESC
    def resource_limit
      r = Sqlpage.new('template/stat/resource_limit.erb')
      vim(sqlplus(r))
    end

    desc "space_show", "space_show"
    long_desc <<-LONGDESC
      Example: omoncli stat space_show --segname="MAILINGS"
      segment_owner Schema name of the segment to be analyzed
      segment_name Name of the segment to be analyzed
      partition_name Partition name of the segment to be analyzed
      segment_type Type of the segment to be analyzed (TABLE, INDEX, or CLUSTER):
            TABLE
            TABLE PARTITION
            TABLE SUBPARTITION
            INDEX
            INDEX PARTITION
            INDEX SUBPARTITION
            CLUSTER
            LOB
            LOB PARTITION
            LOB SUBPARTITION
      unformatted_blocks Total number of blocks unformatted
      unformatted bytes  Total number of bytes unformatted
      fs1_blocks         Number of blocks having at least 0 to 25% free space
      fs1_bytes          Number of bytes having at least 0 to 25% free space
      fs2_blocks         Number of blocks having at least 25 to 50% free space
      fs2_bytes          Number of bytes having at least 25 to 50% free space
      fs3_blocks         Number of blocks having at least 50 to 75% free space
      fs3_bytes          Number of bytes having at least 50 to 75% free space
      fs4_blocks         Number of blocks having at least 75 to 100% free space
      fs4_bytes          Number of bytes having at least 75 to 100% free space
      ful1_blocks        Total number of blocks full in the segment
      full_bytes         Total number of bytes full in the segment
      partition_name Name of the partition (NULL if not a partition)
    LONGDESC
    option :segname, :type => :string, :required => true
    option :owner, :type => :string, :default => 'TOPGAME5'
    option :type, :type => :string, :default => 'TABLE', :enum => ['TABLE','TABLE PARTITION','TABLE SUBPARTITION','INDEX','INDEX PARTITION','INDEX SUBPARTITION','CLUSTER','LOB','LOB PARTITION','LOB SUBPARTITION']
    option :partition, :type => :string, :default => 'NULL'
    def space_show
      Sqlpage.class_eval do
        attr_accessor :segname, :owner, :type, :partition
      end
      r = Sqlpage.new('template/stat/space_show.erb')
      r.segname, r.owner, r.type, r.partition = options[:segname], options[:owner], options[:type], options[:partition]
      vim(sqlplus(r))
    end

    desc "standby", "standby"
    long_desc <<-LONGDESC
      Example: omoncli stat standby
    LONGDESC
    def standby
      r = Sqlpage.new('template/stat/standby.erb')
      vim(sqlplus(r))
    end

    desc "hist_system_event", "hist_system_event"
    long_desc <<-LONGDESC
      omoncli stat hist_system_event --event_name="direct path write temp" --bdate="#{DateTime.now.strftime('%d-%m-%Y %H:00:00')}" --edate="#{DateTime.now.strftime('%d-%m-%Y %H:00:00')}"
    LONGDESC
    option :event_name, :required => true, :type => :string
    option :bdate, :required => true, :type => :string
    option :edate, :required => true, :type => :string
    def hist_system_event
      Sqlpage.class_eval do
        attr_accessor :event_name, :bdate, :edate
      end
      r = Sqlpage.new('template/stat/hist_system_event.erb')
      r.event_name, r.bdate, r.edate = options[:event_name], options[:bdate], options[:edate]
      vim(sqlplus(r))
    end

    desc "asw", "Суммарные ожидания активных сессий"
    long_desc <<-LONGDESC
      omoncli ash topsql --topnum=10
    LONGDESC
    option :topnum, :default => 10, :type => :numeric
    def asw
      Sqlpage.class_eval do
        attr_accessor :topnum
      end
      r = Sqlpage.new('template/stat/asw.erb')
      r.topnum = options[:topnum]
      vim(sqlplus(r))
    end


  end

end
