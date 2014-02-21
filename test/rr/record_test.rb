require 'dns/zone/test_case'

class RR_Record_Test < DNS::Zone::TestCase

  def test_rr_record_defaults
    rr = DNS::Zone::RR::Record.new
    assert_equal '@', rr.label, 'label is @, by default'
    assert_equal nil, rr.ttl, 'ttl is nil, by default'
  end

  def test_rr_record_with_label
    rr = DNS::Zone::RR::Record.new
    rr.label = 'labelname'
    assert_equal 'labelname IN <type>', rr.dump
  end

  def test_rr_record_with_label_and_ttl
    rr = DNS::Zone::RR::Record.new
    rr.label = 'labelname'
    rr.ttl = '2d'
    assert_equal 'labelname 2d IN <type>', rr.dump
  end

  def test_rr_record_with_ttl
    rr = DNS::Zone::RR::Record.new
    rr.ttl = '2d'
    assert_equal '@ 2d IN <type>', rr.dump
  end

end
