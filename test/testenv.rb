require 'yaml'

class Test

  attr_accessor :usertnspassword

  def initialize
    @usertnspassword = {'GRID_LGDBT'=>{'USER'=>'USERNAME','PASSWORD'=>'MYPASS'},'GRID_LGDBT'=>{'USER'=>'USERNAME','PASSWORD'=>'MYPASS'}}
  end
end

a = Test.new
File.open('tttt1.log', "w") {|f| YAML.dump(a, f)}


