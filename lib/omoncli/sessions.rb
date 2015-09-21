module Omoncli

  require 'omoncli/omonbase'

  class Session < Basesubcommand

    desc "active", "Active sessions"
    option :system, :required => false, :type => :boolean
    def active
      Sqlpage.class_eval do
        attr_accessor :system
      end
      r = Sqlpage.new('template/session/active.erb')
      r.system = options[:system]
      vim(sqlplus(r))
    end

    desc "wait_tree", "ASH wait tree for arbitrary condition"
    long_desc <<-LONGDESC
      ASH wait tree for arbitrary condition
      Usage: omoncli session wait_tree --condition="event = 'log file sync'"
      original Igor Usoltsev http://iusoltsev.wordpress.com
      Example condition: "program like '%LGWR%'"
    LONGDESC
    option :condition, :required => true
    def wait_tree
      Sqlpage.class_eval do
        attr_accessor :condition
      end
      r = Sqlpage.new('template/session/wait_tree.erb')
      r.condition = options[:condition]
      vim(sqlplus(r))
    end

    desc "wait_tree_hist", "ASH wait tree history for arbitrary condition between snap_id"
    long_desc <<-LONGDESC
      ASH wait tree for arbitrary condition
      Usage: omoncli session wait_tree --condition="event = 'log file sync'" --snap_id_start=1001 --snap_id_finish=1002
      original Igor Usoltsev http://iusoltsev.wordpress.com
      Example condition: "program like '%LGWR%'"
    LONGDESC
    option :condition, :required => true
    option :snap_id_start, :required => true
    option :snap_id_finish, :required => true
    def wait_tree_hist
      Sqlpage.class_eval do
        attr_accessor :condition, :snap_id_start, :snap_id_finish
      end
      r = Sqlpage.new('template/session/wait_tree_hist.erb')
      r.condition, r.snap_id_start, r.snap_id_finish = options[:condition], options[:snap_id_start], options[:snap_id_finish]
      vim(sqlplus(r))
    end

    desc "locks", "Locks"
    long_desc <<-LONGDESC
      omoncli sessions locks
    LONGDESC
    def locks
      r = Sqlpage.new('template/session/locks.erb')
      vim(sqlplus(r))
    end

    desc "pgausage", "pgausage"
    long_desc <<-LONGDESC
      omoncli sessions pgausage
    LONGDESC
    def pgausage
      r = Sqlpage.new('template/session/pgausage.erb')
      vim(sqlplus(r))
    end

    desc "undosegusage", "undosegusage"
    long_desc <<-LONGDESC
      omoncli sessions undosegusage
    LONGDESC
    def undosegusage
      r = Sqlpage.new('template/session/undosegusage.erb')
      vim(sqlplus(r))
    end

    desc "tempsegusage", "tempsegusage"
    long_desc <<-LONGDESC
      omoncli sessions tempsegusage
    LONGDESC
    def tempsegusage
      r = Sqlpage.new('template/session/tempsegusage.erb')
      vim(sqlplus(r))
    end

    desc "transactions", "transactions"
    long_desc <<-LONGDESC
      omoncli sessions transactions
    LONGDESC
    def transactions
      r = Sqlpage.new('template/session/transactions.erb')
      vim(sqlplus(r))
    end

    desc "sessions_all", "sessions_all"
    long_desc <<-LONGDESC
      omoncli sessions sessions_all
    LONGDESC
    def sessions_all
      r = Sqlpage.new('template/session/sessions_all.erb')
      vim(sqlplus(r))
    end

    desc "sess_io", "sess_io"
    long_desc <<-LONGDESC
      omoncli sessions sess_io --sid=1 --instance=1
    LONGDESC
    option :sid, :required => true, :type => :numeric
    option :instance, :required => true, :type => :numeric
    def sess_io
      Sqlpage.class_eval do
        attr_accessor :sid, :instance
      end
      r = Sqlpage.new('template/session/sess_io.erb')
      r.sid, r.instance = options[:sid], options[:instance]
      vim(sqlplus(r))
    end

    desc "lock_tree", "Current Lock Waits chains based on GV$LOCK"
    def lock_tree
      r = Sqlpage.new('template/session/lock_tree.erb')
      vim(sqlplus(r))
    end


  end

end
