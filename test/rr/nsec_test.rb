require 'dns/zone/test_case'

class RR_NSEC_Test < DNS::Zone::TestCase

  def test_build_rr__nsec
    rr = DNS::Zone::RR::NSEC.new
    rr.label = 'alfa.example.com.'
    rr.next_domain = 'host.example.com.'
    rr.rrset_types = 'A MX RRSIG NSEC TYPE1234'

    assert_equal "alfa.example.com. IN NSEC host.example.com. A MX RRSIG NSEC TYPE1234", rr.dump

  end

  def test_load_rr__nsec
    rr = DNS::Zone::RR::NSEC.new.load("alfa.example.com. IN NSEC host.example.com. A MX RRSIG NSEC TYPE1234")
    assert_equal 'alfa.example.com.', rr.label
    assert_equal 'NSEC', rr.type

    assert_equal 'host.example.com.', rr.next_domain
    assert_equal 'A MX RRSIG NSEC TYPE1234', rr.rrset_types
  end

end
