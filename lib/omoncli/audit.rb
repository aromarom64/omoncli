module Omoncli

  require 'omoncli/omonbase'
  require 'date'

  class Audit < Basesubcommand

    desc "outstanding_alerts", "outstanding_alerts"
    long_desc <<-LONGDESC
      omoncli audit outstanding_alerts"
    LONGDESC
    def outstanding_alerts
      r = Sqlpage.new('template/audit/outstanding_alerts.erb')
      vim(sqlplus(r))
    end

    desc "outstanding_alerts_history", "outstanding_alerts_history"
    long_desc <<-LONGDESC
      omoncli audit outstanding_alerts_history"
    LONGDESC
    option :topnum, :default => 10, :type => :numeric
    def outstanding_alerts_history
      Sqlpage.class_eval do
        attr_accessor :topnum
      end
      r = Sqlpage.new('template/audit/outstanding_alerts_history.erb')
      r.topnum = options[:topnum]
      vim(sqlplus(r))
    end

    desc "audit_trail", "audit_trail"
    long_desc <<-LONGDESC
      omoncli audit audit_trail"
    LONGDESC
    option :topnum, :default => 10, :type => :numeric
    def audit_trail
      Sqlpage.class_eval do
        attr_accessor :topnum
      end
      r = Sqlpage.new('template/audit/audit_trail.erb')
      r.topnum = options[:topnum]
      vim(sqlplus(r))
    end

    desc "stmt_audit_opts", "stmt_audit_opts"
    long_desc <<-LONGDESC
      omoncli audit stmt_audit_opts"
    LONGDESC
    def stmt_audit_opts
      r = Sqlpage.new('template/audit/stmt_audit_opts.erb')
      vim(sqlplus(r))
    end

  end

end
