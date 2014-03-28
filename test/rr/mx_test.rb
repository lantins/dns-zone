require 'dns/zone/test_case'

class RR_MX_Test < DNS::Zone::TestCase

  def test_build_rr__mx
    rr = DNS::Zone::RR::MX.new    

    # ensure we can set preference and exchange parameter
    rr.preference = '10'
    rr.exchange = 'mx0.lividpenguin.com.'
    assert_equal '@ IN MX 10 mx0.lividpenguin.com.', rr.dump

    rr.preference = '20'
    rr.exchange = 'mx1.lividpenguin.com.'
    assert_equal '@ IN MX 20 mx1.lividpenguin.com.', rr.dump
  end

  def test_load_rr__mx
    rr = DNS::Zone::RR::MX.new.load('@ IN MX 20 mx1.lividpenguin.com.')
    assert_equal '@', rr.label
    assert_equal 'MX', rr.type
    assert_equal '20', rr.preference
    assert_equal 'mx1.lividpenguin.com.', rr.exchange
  end

end
