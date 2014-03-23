require 'dns/zone/test_case'

class RR_A_Test < DNS::Zone::TestCase

  def test_build_rr__a
    rr = DNS::Zone::RR::A.new    

    # ensure we can set address parameter
    rr.address = '10.0.1.1'
    assert_equal 'A', rr.type
    assert_equal '@ IN A 10.0.1.1', rr.dump
    rr.address = '10.0.2.2'
    assert_equal '@ IN A 10.0.2.2', rr.dump

    # with a label set
    rr.label = 'labelname'
    assert_equal 'labelname IN A 10.0.2.2', rr.dump

    # with a ttl
    rr.ttl = '4w'
    assert_equal 'labelname 4w IN A 10.0.2.2', rr.dump
  end

  def test_load_rr__a
    rr = DNS::Zone::RR::A.new.load('@ IN A 127.0.0.1')
    assert_equal '@', rr.label
    assert_equal 'A', rr.type
    assert_equal '127.0.0.1', rr.address

    rr = DNS::Zone::RR::A.new.load('www IN A 127.0.0.1')
    assert_equal 'www', rr.label
    assert_equal 'A', rr.type
    assert_equal 'IN', rr.klass
    assert_equal '127.0.0.1', rr.address
  end

end
