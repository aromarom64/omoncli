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

    desc "sysaux_occupants", "Displays information about the contents of the SYSAUX tablespace"
    long_desc <<-LONGDESC
      omoncli tablespace sysaux_occupants
    LONGDESC
    def sysaux_occupants
      r = Sqlpage.new('template/tablespace/sysaux_occupants.erb')
      vim(sqlplus(r))
    end


  end

end
