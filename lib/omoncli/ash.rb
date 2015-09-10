module Omoncli

  require 'omoncli/omonbase'
  require 'date'

  class Ash < Basesubcommand

    desc "ash_report_html", "ash_report_html"
    long_desc <<-LONGDESC
      omoncli ash ash_report_html --instance=1 --bdate="#{DateTime.now.strftime('%d-%m-%Y %H:00:00')}" --edate="#{DateTime.now.strftime('%d-%m-%Y %H:00:00')}"
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

  end

end