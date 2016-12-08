module Omoncli

  require 'omoncli/omonbase'

  class Table < Basesubcommand

    desc "part", "part"
    long_desc <<-LONGDESC
      Example: omoncli table part
    LONGDESC
    option :owner, :type => :string, :default => 'TOPGAME5'
    option :table, :type => :string, :default => 'INFO_DEBUG'
    def part
      Sqlpage.class_eval do
        attr_accessor :table, :owner
      end
      r = Sqlpage.new('template/table/part.erb')
      r.owner, r.table = options[:owner], options[:table]
      vim(sqlplus(r))
    end

    desc "gen_rebuild_indexes", "gen_rebuild_indexes"
    long_desc <<-LONGDESC
      Example: omoncli table gen_rebuild_indexes
    LONGDESC
    option :owner, :type => :string, :required => true
    option :table, :type => :string, :required => true
    option :tablespace, :type => :string, :lazy_default => 'USERS'
    option :online, :type => :string, :lazy_default => 'ONLINE'
    def gen_rebuild_indexes
      Sqlpage.class_eval do
        attr_accessor :table, :owner, :tablespace, :online
      end
      r = Sqlpage.new('template/table/gen_rebuild_indexes.erb')
      r.owner, r.table, r.tablespace, r.online = options[:owner], options[:table], options[:tablespace], options[:online]
      vim(sqlplus(r))
    end

    desc "show_space", "Find exact SQL_ID and PLAN_HASH_VALUE for SPM baseline"
    long_desc <<-LONGDESC
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
    option :segname, :required => true, :type => :string
    option :owner, :required => true, :type => :string
    option :type, :required => true, :type => :string
    option :partition, :type => :string, :lazy_default => ''
    def show_space 
      Sqlpage.class_eval do
        attr_accessor :segname, :owner, :type, :partition
      end
      r = Sqlpage.new('template/table/show_space.erb')
      r.segname, r.owner, r.type, r.partition = options[:segname], options[:owner], options[:type], options[:partition]
      vim(sqlplus(r))
    end


  end

end
