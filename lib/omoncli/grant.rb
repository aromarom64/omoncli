module Omoncli

  require 'omoncli/omonbase'

  class Grant < Basesubcommand

    desc "rolegrant", "rolegrant"
    long_desc <<-LONGDESC
      Example: omoncli grant rolegrant
    LONGDESC
    option :orarole, :default => 'TEXSUPROLE', :type => :string
    def rolegrant
      Sqlpage.class_eval do
        attr_accessor :orarole
      end
      r = Sqlpage.new('template/grant/rolegrant.erb')
      r.orarole= options[:orarole]
      vim(sqlplus(r))
    end

    desc "usergrant", "usergrant"
    long_desc <<-LONGDESC
      Example: omoncli grant usergrant
    LONGDESC
    option :orauser, :default => 'DEV_SERGEY', :type => :string
    def usergrant
      Sqlpage.class_eval do
        attr_accessor :orauser
      end
      r = Sqlpage.new('template/grant/usergrant.erb')
      r.orauser= options[:orauser]
      vim(sqlplus(r))
    end

  end

end
