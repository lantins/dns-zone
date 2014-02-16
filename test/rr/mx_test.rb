require 'dns/zone/test_case'

class RR_MX_Test < DNS::Zone::TestCase

  def test_build_rr__mx
    rr = DNS::Zone::RR::MX.new    

    # ensure we can set preference and exchange parameter
    rr.preference = '10'
    rr.exchange = 'mx0.lividpenguin.com.'
    assert_equal '@ IN MX 10 mx0.lividpenguin.com.', rr.to_s

    rr.preference = '20'
    rr.exchange = 'mx1.lividpenguin.com.'
    assert_equal '@ IN MX 20 mx1.lividpenguin.com.', rr.to_s
  end

end
