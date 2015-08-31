module Omoncli

  require 'omoncli/omonbase'

  class Table < Basesubcommand

    desc "part", "part"
    long_desc <<-LONGDESC
      Example: omoncli table part
    LONGDESC
    option :owner, :type => :string, :default => 'TOPGAME5'
    option :table, :type => :string, :default => 'INFO_DEBUG'
    def part
      Sqlpage.class_eval do
        attr_accessor :table, :owner
      end
      r = Sqlpage.new('template/table/part.erb')
      r.owner, r.table = options[:owner], options[:table]
      vim(sqlplus(r))
    end

    desc "gen_rebuild_indexes", "gen_rebuild_indexes"
    long_desc <<-LONGDESC
      Example: omoncli table gen_rebuild_indexes
    LONGDESC
    option :owner, :type => :string, :required => true
    option :table, :type => :string, :required => true
    option :tablespace, :type => :string, :lazy_default => 'USERS'
    option :online, :type => :string, :lazy_default => 'ONLINE'
    def gen_rebuild_indexes
      Sqlpage.class_eval do
        attr_accessor :table, :owner, :tablespace, :online
      end
      r = Sqlpage.new('template/table/gen_rebuild_indexes.erb')
      r.owner, r.table, r.tablespace, r.online = options[:owner], options[:table], options[:tablespace], options[:online]
      vim(sqlplus(r))
    end


  end

end
