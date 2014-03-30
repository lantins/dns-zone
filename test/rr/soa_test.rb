require 'dns/zone/test_case'

class RR_SOA_Test < DNS::Zone::TestCase

  EXAMPLE_SOA_IN  = '@ IN SOA ns0.lividpenguin.com. luke.lividpenguin.com. 2014021601 3h 15m 4w 30m'
  EXAMPLE_SOA_OUT = '@ IN SOA ns0.lividpenguin.com. luke.lividpenguin.com. ( 2014021601 3h 15m 4w 30m )'

  def test_build_rr__soa
    rr = DNS::Zone::RR::SOA.new
    rr.nameserver = 'ns0.lividpenguin.com.'
    rr.email = 'luke.lividpenguin.com.'
    rr.serial = 2014_02_16_01
    rr.refresh_ttl = '3h'
    rr.retry_ttl = '15m'
    rr.expiry_ttl = '4w'
    rr.minimum_ttl = '30m'
    assert_equal EXAMPLE_SOA_OUT, rr.dump
  end

  def test_load_rr__soa
    rr = DNS::Zone::RR::SOA.new.load(EXAMPLE_SOA_IN)
    assert_equal '@', rr.label
    assert_equal 'SOA', rr.type

    assert_equal 'ns0.lividpenguin.com.', rr.nameserver
    assert_equal 'luke.lividpenguin.com.', rr.email
    assert_equal 2014_02_16_01, rr.serial
    assert_equal '3h', rr.refresh_ttl
    assert_equal '15m', rr.retry_ttl
    assert_equal '4w', rr.expiry_ttl
    assert_equal '30m', rr.minimum_ttl
  end

end
