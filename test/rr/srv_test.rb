require 'dns/zone/test_case'

class RR_SRV_Test < DNS::Zone::TestCase

  def test_build_rr__srv
    rr = DNS::Zone::RR::SRV.new
    rr.priority = 5
    rr.weight = 0
    rr.port = 5269
    rr.target = 'xmpp-server.l.google.com.'
    assert_equal '@ IN SRV 5 0 5269 xmpp-server.l.google.com.', rr.dump
  end

  def test_load_rr__srv
    rr = DNS::Zone::RR::SRV.new.load('@ IN SRV 5 0 5269 xmpp-server.l.google.com.')
    assert_equal '@', rr.label
    assert_equal 'SRV', rr.type
    assert_equal 5, rr.priority
    assert_equal 0, rr.weight
    assert_equal 5269, rr.port
    assert_equal 'xmpp-server.l.google.com.', rr.target
  end

end
