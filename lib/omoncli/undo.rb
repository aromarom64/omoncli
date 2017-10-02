module Omoncli

  require 'omoncli/omonbase'

  class Undo < Basesubcommand

    desc "extents", "extents"
    long_desc <<-LONGDESC
      Example: omoncli undo extents
    LONGDESC
    def extents
      r = Sqlpage.new('template/undo/extents.erb')
      vim(sqlplus(r))
    end

    desc "stat", "stat"
    long_desc <<-LONGDESC
      omoncli undo stat --hour=1
    LONGDESC
    option :hour, :default => 1, :type => :numeric
    def stat
      Sqlpage.class_eval do
        attr_accessor :hour
      end
      r = Sqlpage.new('template/undo/stat.erb')
      r.hour = options[:hour]
      vim(sqlplus(r))
    end

    desc "fast_start_transactions", "fast_start_transactions"
    long_desc <<-LONGDESC
      Example: omoncli undo fast_start_transactions
    LONGDESC
    def fast_start_transactions
      r = Sqlpage.new('template/undo/fast_start_transactions.erb')
      vim(sqlplus(r))
    end

  end

end
