require 'dns/zone/test_case'

class RR_AAAA_Test < DNS::Zone::TestCase

  def test_build_rr__aaaa
    rr = DNS::Zone::RR::AAAA.new    

    # ensure we can set address parameter
    rr.address = '2001:db8::3'
    assert_equal 'AAAA', rr.type
    assert_equal '@ IN AAAA 2001:db8::3', rr.dump
  end

  def test_load_rr__aaaa
    rr = DNS::Zone::RR::AAAA.new.load('@ IN AAAA 2001:db8::6')
    assert_equal '@', rr.label
    assert_equal 'AAAA', rr.type
    assert_equal '2001:db8::6', rr.address

    rr = DNS::Zone::RR::AAAA.new.load('www IN A 2001:db8::6')
    assert_equal 'www', rr.label
    assert_equal 'AAAA', rr.type
    assert_equal 'IN', rr.klass
    assert_equal '2001:db8::6', rr.address
  end

end
