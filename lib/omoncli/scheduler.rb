module Omoncli

  require 'omoncli/omonbase'
  require 'date'

  class Scheduler < Basesubcommand

    desc "jobsrunning", "jobs"
    long_desc <<-LONGDESC
      omoncli cursor sql --sql_id="4642q2v2331zj"
    LONGDESC
    def jobsrunning
      r = Sqlpage.new('template/scheduler/jobsrunning.erb')
      vim(sqlplus(r))
    end

    desc "logs_scheduler", "logs_scheduler"
    long_desc <<-LONGDESC
      omoncli scheduler logs_scheduler
    LONGDESC
    option :topnumber, :default => 30, :type => :numeric
    option :jobname, :required => true, :type => :string
    option :owner, :required => true, :type => :string
    def logs_scheduler
      Sqlpage.class_eval do
        attr_accessor :topnumber, :jobname, :owner
      end
      r = Sqlpage.new('template/scheduler/logs_scheduler.erb')
      r.topnumber, r.jobname, r.owner = options[:topnumber], options[:jobname], options[:owner]
      vim(sqlplus(r))
    end

    desc "jobs_scheduler", "jobs_scheduler"
    long_desc <<-LONGDESC
      omoncli scheduler jobs_scheduler
    LONGDESC
    def jobs_scheduler
      r = Sqlpage.new('template/scheduler/jobs_scheduler.erb')
      vim(sqlplus(r))
    end

    desc "history", "history"
    long_desc <<-LONGDESC
      omoncli scheduler history
    LONGDESC
    def history
      r = Sqlpage.new('template/scheduler/history.erb')
      vim(sqlplus(r))
    end

  end

end
