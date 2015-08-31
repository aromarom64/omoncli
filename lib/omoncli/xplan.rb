module Omoncli

  require 'omoncli/omonbase'

  class Xplan < Basesubcommand

    desc "display_cursor", "dbms_xplan.display_cursor"
    long_desc <<-LONGDESC
      omoncli xplan display_cursor --sql_id="4642q2v2331zj"
      Example format: ALL ALLSTATS LAST or ADVANCED ALLSTATS LAST or ALL +PEEKED_BINDS
    LONGDESC
    option :sql_id, :required => true, :type => :string
    option :child, :type => :numeric, :default => 0
    option :format, :type => :string, :default => 'TYPICAL'
    def display_cursor
      Sqlpage.class_eval do
        attr_accessor :sql_id, :child, :format
      end
      r = Sqlpage.new('template/xplan/display_cursor.erb')
      r.sql_id, r.child, r.format = options[:sql_id], options[:child], options[:format]
      vim(sqlplus(r))
    end

    desc "display_awr", "dbms_xplan.display_cursor"
    long_desc <<-LONGDESC
      omoncli xplan display_awr --sql_id="4642q2v2331zj"
      Example format: ALL ALLSTATS LAST or ADVANCED ALLSTATS LAST or ALL +PEEKED_BINDS
    LONGDESC
    option :sql_id, :required => true, :type => :string
    option :plan_hash_value, :type => :numeric, :lazy_default => 0
    option :db_id, :type => :numeric, :lazy_default => 0
    option :format, :type => :string, :default => 'TYPICAL'
    def display_awr
      Sqlpage.class_eval do
        attr_accessor :sql_id, :plan_hash_value, :db_id, :format
      end
      r = Sqlpage.new('template/xplan/display_awr.erb')
      r.sql_id, r.plan_hash_value, r.db_id, r.format = options[:sql_id], options[:plan_hash_value], options[:db_id], options[:format]
      vim(sqlplus(r))
    end

    desc "display_sql_plan_baseline", "dbms_xplan.display_sql_plan_baseline"
    long_desc <<-LONGDESC
      omoncli xplan display_sql_plan_baseline --sql-handle=""
      Example format: TYPICAL, BASIC.
      select * from dba_sql_plan_baselines order by created desc;
    LONGDESC
    option :sql_handle, :required => true, :type => :string
    option :plan_name, :type => :string, :lazy_default => ''
    option :format, :type => :string, :default => 'TYPICAL'
    def display_sql_plan_baseline
      Sqlpage.class_eval do
        attr_accessor :sql_handle, :plan_name, :format
      end
      r = Sqlpage.new('template/xplan/display_sql_plan_baseline.erb')
      r.sql_handle, r.plan_name, r.format = options[:sql_handle], options[:plan_name], options[:format]
      vim(sqlplus(r))
    end

  end

end
