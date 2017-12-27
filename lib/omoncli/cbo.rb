module Omoncli

  require 'omoncli/omonbase'

  class Cbo < Basesubcommand

    desc "bl_check", "Check SPM baseline existance for exact SQL_ID"
    long_desc <<-LONGDESC
      omoncli cbo bl_check --sql_id="4642q2v2331zj"
    LONGDESC
    option :sql_id, :required => true, :type => :string
    def bl_check
      Sqlpage.class_eval do
        attr_accessor :sql_id
      end
      r = Sqlpage.new('template/cbo/bl_check.erb')
      r.sql_id = options[:sql_id]
      vim(sqlplus(r))
    end

    desc "bl_find", "Find exact SQL_ID and PLAN_HASH_VALUE for SPM baseline"
    long_desc <<-LONGDESC
      This query exetues VERY VERY SLOW, full scan
      Find exact SQL_ID and PLAN_HASH_VALUE for SPM baseline,
      searching for the matching sql text and plan outlines in Shared pool and AWR
    LONGDESC
    option :sql_handle, :required => true, :type => :string
    option :plan_name, :type => :string, :lazy_default => ''
    def bl_find
      Sqlpage.class_eval do
        attr_accessor :sql_handle, :plan_name
      end
      r = Sqlpage.new('template/cbo/bl_find.erb')
      r.sql_handle, r.plan_name = options[:sql_handle], options[:plan_name]
      vim(sqlplus(r))
    end

    desc "sql_plan_diff_outl", "SQL Plan Outline sections diff"
    long_desc <<-LONGDESC
      SQL Plan Outline sections diff
      omoncli cbo sql_plan_diff_outl --sql_id1="" --plan_hash_value1="" --sql_id2="" --plan_hash_value2=""
    LONGDESC
    option :sql_id1, :required => true, :type => :string
    option :plan_hash_value1, :required => true, :type => :string
    option :sql_id2, :required => true, :type => :string
    option :plan_hash_value2, :required => true, :type => :string
    option :query_block_name, :type => :string, :lazy_default => ''
    def sql_plan_diff_outl 
      Sqlpage.class_eval do
        attr_accessor :sql_id1, :plan_hash_value1, :sql_id2, :plan_hash_value2, :query_block_name
      end
      r = Sqlpage.new('template/cbo/sql_plan_diff_outl.erb')
      r.sql_id1, r.plan_hash_value1, r.sql_id2, r.plan_hash_value2, r.query_block_name = 
        options[:sql_id1], options[:plan_hash_value1], options[:sql_id2], options[:plan_hash_value2], options[:query_block_name]
      vim(sqlplus(r))
    end



  end

end
