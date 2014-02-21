require 'dns/zone/test_case'

class RR_CNAME_Test < DNS::Zone::TestCase

  def test_build_rr__cname
    rr = DNS::Zone::RR::CNAME.new
    rr.label = 'google9d97d7f266ee521d'
    rr.domainname = 'google.com.'
    assert_equal 'google9d97d7f266ee521d IN CNAME google.com.', rr.dump
  end

end
