require 'dns/zone/test_case'

class RR_CNAME_Test < DNS::Zone::TestCase

  def test_build_rr__cname
    rr = DNS::Zone::RR::CNAME.new
    rr.label = 'google9d97d7f266ee521d'
    rr.domainname = 'google.com.'
    assert_equal 'google9d97d7f266ee521d IN CNAME google.com.', rr.dump
  end

  def test_load_rr__cname
    rr = DNS::Zone::RR::CNAME.new.load('foo IN CNAME example.com.')
    assert_equal 'foo', rr.label
    assert_equal 'CNAME', rr.type
    assert_equal 'example.com.', rr.domainname
  end

end
