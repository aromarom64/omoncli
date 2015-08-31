module Omoncli

  require 'omoncli/omonbase'
  require 'date'

  class Rman < Basesubcommand

    desc "backup_details", "Rman rman_backup_job_details"
    long_desc <<-LONGDESC
      omoncli rman backup_details
    LONGDESC
    option :day, :default => 30, :type => :numeric
    def backup_details
      Sqlpage.class_eval do
        attr_accessor :day
      end
      r = Sqlpage.new('template/rman/backup_details.erb')
      r.day = options[:day]
      vim(sqlplus(r))
    end

  end

end
