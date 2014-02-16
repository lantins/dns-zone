require 'dns/zone/test_case'

class RR_AAAA_Test < DNS::Zone::TestCase

  def test_build_rr__aaaa
    rr = DNS::Zone::RR::AAAA.new    

    # ensure we can set address parameter
    rr.address = '2001:db8::3'
    assert_equal '@ IN AAAA 2001:db8::3', rr.to_s
  end

end
