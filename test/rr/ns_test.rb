require 'dns/zone/test_case'

class RR_NS_Test < DNS::Zone::TestCase

  def test_build_rr__ns
    rr = DNS::Zone::RR::NS.new
    rr.nameserver = 'ns0.lividpenguin.com.'
    assert_equal '@ IN NS ns0.lividpenguin.com.', rr.to_s
  end

end
