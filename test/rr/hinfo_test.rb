require 'dns/zone/test_case'

class RR_HINFO_Test < DNS::Zone::TestCase

  def test_build_rr__hinfo
    rr = DNS::Zone::RR::HINFO.new
    rr.cpu = 'Intel'
    rr.os = 'Ubuntu'
    assert_equal '@ IN HINFO "Intel" "Ubuntu"', rr.dump
  end

  def test_build_with_spaces
    rr = DNS::Zone::RR::HINFO.new
    rr.label = 'ns0'
    rr.cpu = 'PC Intel 700mhz'
    rr.os = 'Ubuntu 12.04 LTS'
    assert_equal 'ns0 IN HINFO "PC Intel 700mhz" "Ubuntu 12.04 LTS"', rr.dump
  end

  def test_load_rr__hinfo
    rr = DNS::Zone::RR::HINFO.new.load('ns0 IN HINFO "Intel" "Ubuntu"')
    assert_equal 'ns0', rr.label
    assert_equal 'HINFO', rr.type
    assert_equal 'Intel', rr.cpu
    assert_equal 'Ubuntu', rr.os
  end

  def test_load_with_spaces
    rr = DNS::Zone::RR::HINFO.new.load('ns0 IN HINFO "PC Intel 700mhz" "Ubuntu 12.04 LTS"')
    assert_equal 'PC Intel 700mhz', rr.cpu
    assert_equal 'Ubuntu 12.04 LTS', rr.os
  end

  def test_load_mixed_quotes
    rr = DNS::Zone::RR::HINFO.new.load('ns0 IN HINFO Intel "Ubuntu 12.04"')
    assert_equal 'Intel', rr.cpu
    assert_equal 'Ubuntu 12.04', rr.os

    rr = DNS::Zone::RR::HINFO.new.load('ns0 IN HINFO "PC Intel" Ubuntu')
    assert_equal 'PC Intel', rr.cpu
    assert_equal 'Ubuntu', rr.os
  end

end
