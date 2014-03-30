require 'dns/zone/test_case'

class RR_SPF_Test < DNS::Zone::TestCase

  def test_build_rr__spf
    rr = DNS::Zone::RR::SPF.new
    rr.ttl = '2w'
    rr.text = 'v=spf1 +mx -all'
    assert_equal '@ 2w IN SPF "v=spf1 +mx -all"', rr.dump
  end

  def test_load_rr__spf
    rr = DNS::Zone::RR::SPF.new.load('@ 2w IN SPF "v=spf1 +mx -all"')
    assert_equal '@', rr.label
    assert_equal 'IN', rr.klass
    assert_equal 'SPF', rr.type
    assert_equal 'v=spf1 +mx -all', rr.text
  end

end
