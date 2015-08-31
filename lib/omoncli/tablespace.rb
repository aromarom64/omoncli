module Omoncli

  require 'omoncli/omonbase'
  require 'date'

  class Tablespace < Basesubcommand

    desc "tablespace", "tablespace"
    long_desc <<-LONGDESC
      omoncli tablespace tablespace
    LONGDESC
    def tablespace
      r = Sqlpage.new('template/tablespace/tablespace.erb')
      vim(sqlplus(r))
    end

    desc "usage", "usage"
    long_desc <<-LONGDESC
      omoncli tablespace usage
    LONGDESC
    def usage
      r = Sqlpage.new('template/tablespace/usage.erb')
      vim(sqlplus(r))
    end

  end

end
