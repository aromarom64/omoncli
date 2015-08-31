module Omoncli

  require 'omoncli/omonbase'
  require 'date'

  class Cursor < Basesubcommand

    desc "sql", "gv$sql"
    long_desc <<-LONGDESC
      omoncli cursor sql --sql_id="4642q2v2331zj"
    LONGDESC
    option :sql_id, :required => true
    def sql
      Sqlpage.class_eval do
        attr_accessor :sql_id
      end
      r = Sqlpage.new('template/cursor/sql.erb')
      r.sql_id = options[:sql_id]
      vim(sqlplus(r))
    end

    desc "sqlarea", "gv$sql"
    long_desc <<-LONGDESC
      omoncli cursor sqlarea --sql_id="4642q2v2331zj"
    LONGDESC
    option :sql_id, :required => true
    def sqlarea
      Sqlpage.class_eval do
        attr_accessor :sql_id
      end
      r = Sqlpage.new('template/cursor/sqlarea.erb')
      r.sql_id = options[:sql_id]
      vim(sqlplus(r))
    end

    desc "sqltext", "gv$sqltext_with_newlines"
    long_desc <<-LONGDESC
      omoncli cursor sqltext --sql_id="4642q2v2331zj"
    LONGDESC
    option :sql_id, :required => true
    option :instance, :type => :numeric, :default => 1, :enum => [1,2]
    def sqltext
      Sqlpage.class_eval do
        attr_accessor :sql_id, :instance
      end
      r = Sqlpage.new('template/cursor/sqltext.erb')
      r.sql_id,r.instance = options[:sql_id],options[:instance]
      vim(sqlplus(r))
    end

    desc "sqlshared", "v$sql_shared_cursor"
    long_desc <<-LONGDESC
      omoncli cursor sqlshared --sql_id="4642q2v2331zj"
    LONGDESC
    option :sql_id, :required => true
    def sqlshared
      Sqlpage.class_eval do
        attr_accessor :sql_id
      end
      r = Sqlpage.new('template/cursor/sqlshared.erb')
      r.sql_id = options[:sql_id]
      vim(sqlplus(r))
    end

    desc "opencursors", "opencursors"
    long_desc <<-LONGDESC
      omoncli sessions opencursors --sid=1 --instance=1
    LONGDESC
    option :sid, :required => true, :type => :numeric
    option :instance, :required => true, :type => :numeric
    def opencursors
      Sqlpage.class_eval do
        attr_accessor :sid, :instance
      end
      r = Sqlpage.new('template/cursor/opencursors.erb')
      r.sid, r.instance = options[:sid], options[:instance]
      vim(sqlplus(r))
    end

  end

end
