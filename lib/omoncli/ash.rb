module Omoncli

  require 'omoncli/omonbase'
  require 'date'

  class Ash < Basesubcommand

    desc "ash_report_html", "ash_report_html"
    long_desc <<-LONGDESC
      omoncli ash ash_report_html --instance=1 --bdate="#{(DateTime.now - Rational(1, 24)).strftime('%d-%m-%Y %H:00:00')}" --edate="#{(DateTime.now - Rational(2, 24)).strftime('%d-%m-%Y %H:00:00')}"
    LONGDESC
    option :instance, :required => true
    option :bdate, :required => true
    option :edate, :required => true
    def ash_report_html
      Sqlpage.class_eval do
        attr_accessor :instance, :bdate, :edate
      end
      r = Sqlpage.new('template/ash/ash_report_html.erb','.html')
      r.instance, r.bdate, r.edate = options[:instance], options[:bdate], options[:edate]
      firefox(sqlplus(r))
    end

    desc "topsql", "top sql"
    long_desc <<-LONGDESC
      omoncli ash topsql --minute=10 --topnum=10
    LONGDESC
    option :minutes, :default => 10, :type => :numeric
    option :topnum, :default => 10, :type => :numeric
    def topsql
      Sqlpage.class_eval do
        attr_accessor :minutes, :topnum
      end
      r = Sqlpage.new('template/ash/topsql.erb')
      r.minutes,r.topnum = options[:minutes],options[:topnum]
      vim(sqlplus(r))
    end

    desc "event_time", "Sql event from minute ago"
    long_desc <<-LONGDESC
      omoncli ash event_time --event="direct path read" --minutes=10
    LONGDESC
    option :minutes, :default => 10, :type => :numeric
    option :event, :type => :string, :required => true
    def event_time
      Sqlpage.class_eval do
        attr_accessor :minutes, :event
      end
      r = Sqlpage.new('template/ash/event_time.erb')
      r.minutes,r.event= options[:minutes],options[:event]
      vim(sqlplus(r))
    end

    desc "sql_time", "Sql from minute ago"
    long_desc <<-LONGDESC
      omoncli ash event_time --sql_id="" --minutes=10
    LONGDESC
    option :minutes, :default => 10, :type => :numeric
    option :sql_id, :required => true, :type => :string
    def sql_time
      Sqlpage.class_eval do
        attr_accessor :minutes, :sql_id
      end
      r = Sqlpage.new('template/ash/sql_time.erb')
      r.minutes,r.sql_id= options[:minutes],options[:sql_id]
      vim(sqlplus(r))
    end

    desc "sql_exec", "Sql from sql_exec_id"
    long_desc <<-LONGDESC
      omoncli ash sql_exec --sql_id="" --sql_exec_id=10
      if versql=1 then use SQL Plan Statistics for SQL_EXEC_ID from ASH
      http://iusoltsev.wordpress.com ASH_SQLMON.SQL
    LONGDESC
    option :sql_exec_id, :required => true, :type => :numeric
    option :sql_id, :required => true, :type => :string
    option :versql, :default => 0, :type => :numeric
    def sql_exec
      Sqlpage.class_eval do
        attr_accessor :sql_exec_id, :sql_id, :versql
      end
      r = Sqlpage.new('template/ash/sql_exec.erb')
      r.sql_exec_id,r.sql_id,r.versql = options[:sql_exec_id],options[:sql_id],options[:versql]
      vim(sqlplus(r))
    end

    desc "lock_tree", "lock_tree"
    long_desc <<-LONGDESC
      omoncli ash lock_tree --bdate="#{DateTime.now.strftime('%d-%m-%Y %H:00:00')}" --edate="#{DateTime.now.strftime('%d-%m-%Y %H:00:00')}"
    LONGDESC
    option :bdate, :required => true
    option :edate, :required => true
    def lock_tree
      Sqlpage.class_eval do
        attr_accessor :bdate, :edate
      end
      r = Sqlpage.new('template/ash/lock_tree.erb')
      r.bdate, r.edate = options[:bdate], options[:edate]
      vim(sqlplus(r))
    end

    desc "awr_report_html", "awr_report_html"
    long_desc <<-LONGDESC
      omoncli ash awr_report_html --instance=1 --bdate="#{(DateTime.now - Rational(1, 24)).strftime('%d-%m-%Y %H:00:00')}" --edate="#{(DateTime.now - Rational(2, 24)).strftime('%d-%m-%Y %H:00:00')}"
    LONGDESC
    option :instance, :required => true
    option :bdate, :required => true
    option :edate, :required => true
    def awr_report_html
      Sqlpage.class_eval do
        attr_accessor :instance, :bdate, :edate
      end
      r = Sqlpage.new('template/ash/awr_report_html.erb','.html')
      r.instance, r.bdate, r.edate = options[:instance], options[:bdate], options[:edate]
      firefox(sqlplus(r))
    end

    desc "awr_diff_report_html", "awr_diff_report_html"
    long_desc <<-LONGDESC
      omoncli ash awr_diff_report_html --instance1=1 --bdate1="#{(DateTime.now - Rational(2, 24)).strftime('%d-%m-%Y %H:00:00')}" --edate1="#{(DateTime.now - Rational(1, 24)).strftime('%d-%m-%Y %H:00:00')}" --instance2=2 --bdate2="#{(DateTime.now - Rational(2, 24)).strftime('%d-%m-%Y %H:00:00')}" --edate2="#{(DateTime.now - Rational(1, 24)).strftime('%d-%m-%Y %H:00:00')}"
    LONGDESC
    option :instance1, :required => true
    option :bdate1, :required => true
    option :edate1, :required => true
    option :instance2, :required => true
    option :bdate2, :required => true
    option :edate2, :required => true
    def awr_diff_report_html
      Sqlpage.class_eval do
        attr_accessor :instance1, :bdate1, :edate1, :instance2, :bdate2, :edate2
      end
      r = Sqlpage.new('template/ash/awr_diff_report_html.erb','.html')
      r.instance1, r.bdate1, r.edate1, r.instance2, r.bdate2, r.edate2 = options[:instance1], options[:bdate1], options[:edate1], options[:instance2], options[:bdate2], options[:edate2]
      firefox(sqlplus(r))
    end

    desc "ash_io_waits", "ASH I/O waits sql_id"
    long_desc <<-LONGDESC
      omoncli ash ash_io_waits --hist --filter="begin_interval_time between to_date(''#{(DateTime.now-2.0/24).strftime('%d-%m-%Y %H:00:00')}'',''dd-mm-yyyy HH24:MI:SS'') and to_date(''#{(DateTime.now).strftime('%d-%m-%Y %H:00:00')}'',''dd-mm-yyyy HH24:MI:SS'')"
    LONGDESC
    option :numtop, :default => 20, :type => :numeric
    option :order, :type => :string,  :default => 'blocks', :enum => ['blocks','waits','reqs']
    option :filter, :default => 'sample_time > sysdate - 1/24', :type => :string
    option :hist, :default => false, :type => :boolean

    def ash_io_waits
      Sqlpage.class_eval do
        attr_accessor :numtop, :filter, :order, :hist
      end
      r = Sqlpage.new('template/ash/ash_io_waits.erb')
      r.numtop, r.order, r.filter, r.hist = options[:numtop], options[:order], options[:filter], options[:hist]
      vim(sqlplus(r))
    end


    desc "ash_iobj_waits", "ASH I/O waits obj"
    long_desc <<-LONGDESC
      omoncli ash ash_iobj_waits --hist --filter="begin_interval_time between to_date(''#{(DateTime.now-2.0/24).strftime('%d-%m-%Y %H:00:00')}'',''dd-mm-yyyy HH24:MI:SS'') and to_date(''#{(DateTime.now).strftime('%d-%m-%Y %H:00:00')}'',''dd-mm-yyyy HH24:MI:SS'')"
    LONGDESC
    option :numtop, :default => 20, :type => :numeric
    option :order, :type => :string,  :default => 'blocks', :enum => ['blocks','waits','reqs']
    option :filter, :default => 'sample_time > sysdate - 1/24', :type => :string
    option :hist, :default => false, :type => :boolean

    def ash_iobj_waits
      Sqlpage.class_eval do
        attr_accessor :numtop, :filter, :order, :hist
      end
      r = Sqlpage.new('template/ash/ash_iobj_waits.erb')
      r.numtop, r.order, r.filter, r.hist = options[:numtop], options[:order], options[:filter], options[:hist]
      vim(sqlplus(r))
    end


    desc "ash_tempu_by_sql", "ASH Temp usage by sql_id"
    long_desc <<-LONGDESC
      omoncli ash ash_tempu_by_sql --hist --filter="begin_interval_time between to_date(''#{(DateTime.now-2.0/24).strftime('%d-%m-%Y %H:00:00')}'',''dd-mm-yyyy HH24:MI:SS'') and to_date(''#{(DateTime.now).strftime('%d-%m-%Y %H:00:00')}'',''dd-mm-yyyy HH24:MI:SS'')"
    LONGDESC
    option :numtop, :default => 20, :type => :numeric
    option :filter, :default => 'sample_time > sysdate - 1/24', :type => :string
    option :hist, :default => false, :type => :boolean

    def ash_tempu_by_sql
      Sqlpage.class_eval do
        attr_accessor :numtop, :filter, :hist
      end
      r = Sqlpage.new('template/ash/ash_tempu_by_sql.erb')
      r.numtop, r.filter, r.hist = options[:numtop], options[:filter], options[:hist]
      vim(sqlplus(r))
    end

  end

end
