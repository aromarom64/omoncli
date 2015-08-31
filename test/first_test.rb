#require 'test_helper'
require 'test/unit'
require_relative '../lib/omoncli/omonsql.rb'

class DefaultTest < Test::Unit::TestCase

  def setup
  end

  def teardown
  end

  def test_the_truth
    assert true
  end
end

class OmonbaseTest < Test::Unit::TestCase
  def test_the_truth
    r = Omoncli::TSQLReport.new('gameuser','xbnfntkm','grid_lgdbt', 'mynew1')
    t = Omoncli::TSQLTask.new('fromdual')
    t.sqltext = 'select * from dual'
    c1 = Omoncli::TSQLParamNumber.new('p1','123')
    c2 = Omoncli::TSQLParamVarchar2.new('p2','123',30)
    t.add_param(c1)
    t.add_param(c2)
    t.add_column(Omoncli::TSQLColumn.new('field1','A30'))
    r.add_sqltask(t)
    puts r.generate
    #r.sqlplus
    assert true
  end

  def test_the_truth1
    r = Omoncli::TSQLReport.new('gameuser','xbnfntkm','grid_lgdbt','mynew2')
    t = Omoncli::TSQLTask.new('fromdual')
    t.sqltext = 'select * from dual'
    c1 = Omoncli::TSQLParamNumber.new('p1','123')
    c2 = Omoncli::TSQLParamVarchar2.new('p2','123',30)
    t.add_param(c1)
    t.add_param(c2)
    t.add_column(Omoncli::TSQLColumn.new('field1','A30'))
    r.add_sqltask(t)
    r.save_to_file
    assert true
  end

  def test_the_truth2
    r = Omoncli::TSQLReport.new('gameuser','xbnfntkm','grid_lgdbt','mynew2')
    t = Omoncli::TSQLTask.new('fromdual')
    t.sqltext = 'select * from dual'
    t.add_param([Omoncli::TSQLParamNumber.new('p1','123'), Omoncli::TSQLParamVarchar2.new('p2','123',30)])
    t.add_column([Omoncli::TSQLColumn.new('field1','A30')])
    r.add_sqltask(t)
    r.save_to_file
    assert true
  end

end
