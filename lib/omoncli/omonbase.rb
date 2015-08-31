module Omoncli

  require 'thor'
  require 'yaml'
  require 'highline'
  require 'tempfile'
  require 'tmpdir'
  require 'erb'

  class Sqlpage

    attr_accessor :service, :username, :password, :template
    attr_reader :filenamespool
    attr_accessor :_trim_mode

    def initialize(template, extspool = '.log')
      sub = 'VERY_LONG_STRING'
      @template = template
      filename = '/tmp/' + _make_tmpname([sub, extspool])
      basename = File.basename(template, '.erb')
      if filename.length - sub.length + basename.length < MAX_FILE_NAME_LENGTH_SPOOL - 1
        filename.gsub! sub, basename
      end
      @filenamespool = filename
      @_trim_mode = nil
    end

    def render path
      content = File.read(File.expand_path(path, File.dirname(__FILE__)))
      t = ERB.new(content,nil,@_trim_mode)
      t.result(binding)
    end

    private

    MAX_FILE_NAME_LENGTH_SPOOL = 54

    def _make_tmpname(prefix_suffix)
      case prefix_suffix
      when Array
        prefix = prefix_suffix[0]
        suffix = prefix_suffix[1]
      else
        raise ArgumentError, "unexpected prefix_suffix: #{prefix_suffix.inspect}"
      end
      t = Time.now.strftime("%Y%m%d-%H%M%S")
      path = "#{prefix}#{t}-#{$$}-#{rand(0x100000000).to_s(36)}"
      path << suffix
    end

  end

  class DialogTnsnames

    attr_reader :service

    TNSNAMES = "#{ENV['HOME']}/gitrepos/oracle/tnsnames.ora"

    def initialize
      @tns = []
      File.foreach(TNSNAMES) do |line|
        if line =~ /^ *[a-zA-Z]/
          @tns << line.sub(/\s*=/,"").chop.downcase
        end
      end
    end

    def dialog
      hl = HighLine.new
      hl.choose do |menu|
        #      menu.layout = :one_line
        menu.header = "TNS"
        menu.prompt = "Favorite? "
        @tns.each do |n|
          menu.choice n do @service = n end
        end
      end
    end

  end

  class Oraenv

    attr_accessor :orauser, :orapass, :oraserv

    CONFIGFILE = "#{ENV['HOME']}/.config/omoncli/oraenv.yaml"

    def initialize
      @orauser, @orapass, @oraserv= 'gameuser', 'xbnfntkm', 'grid_lgdbt'
    end

    def to_yaml_properties
      %w{ @orauser @orapass @oraserv }
    end

  end

  class Basesubcommand < Thor

    class_option :showsql, :type => :boolean

    protected
    def sqlplus(page)
      oraenv = Oraenv.new
      if File.file?(Oraenv::CONFIGFILE)
        oraenv = YAML.load(File.open(Oraenv::CONFIGFILE))
      else
        File.open(Oraenv::CONFIGFILE, "w") {|f| YAML.dump(oraenv, f)}
      end
      page.service = oraenv.oraserv
      page.username = oraenv.orauser
      page.password = oraenv.orapass
      content = page.render page.template
      if options[:showsql]
        log = _save_to_file(content)
      else
        _sqlplus content
        log = page.filenamespool
      end
      log
    end

    def vim(filename)
      Kernel.exec("vim -R -c \"set nofen\" -c \"set nowrap\" #{filename}")
    end

    def firefox(filename)
      if options[:showsql]
        vim(filename)
      else
        Kernel.exec("firefox #{filename}")
      end
    end

    private

    def _save_to_file(content)
      result = filename = '/tmp/' + Dir::Tmpname::make_tmpname(['file', '.sql'],false)
      file = File.new(filename, "w+")
      begin
        file.write(content)
      rescue
        file.close
        raise
      end
      file.close
      result
    end

    def _sqlplus(content)
      file = _save_to_file content
      execstr = "sqlplus /nolog @#{file}"
      begin
        Kernel.system(execstr)
      rescue
        raise
      end
      File.delete(file)
    end

  end

end


