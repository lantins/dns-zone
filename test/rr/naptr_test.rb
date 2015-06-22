require 'dns/zone/test_case'

class RR_NAPTR_Test < DNS::Zone::TestCase

  def test_build_rr__naptr
    rr = DNS::Zone::RR::NAPTR.new
    rr.order = 100
    rr.pref = 10
    rr.flags = ''
    rr.service = ''
    rr.regexp = '!^urn:cid:.+@([^\.]+\.)(.*)$!\2!i'
    rr.replacement = '.'

    assert_equal '@ IN NAPTR 100 10 "" "" "!^urn:cid:.+@([^\.]+\.)(.*)$!\2!i" .', rr.dump
  end

  def test_load_rr__naptr
    rr = DNS::Zone::RR::NAPTR.new.load('@ IN NAPTR 100 10 "" "" "!^urn:cid:.+@([^\.]+\.)(.*)$!\2!i" .')
    assert_equal '@', rr.label
    assert_equal 'NAPTR', rr.type
    assert_equal 100, rr.order
    assert_equal 10, rr.pref
    assert_equal '', rr.flags
    assert_equal '', rr.service
    assert_equal '!^urn:cid:.+@([^\\.]+\\.)(.*)$!\\2!i', rr.regexp
    assert_equal '.', rr.replacement

    rr = DNS::Zone::RR::NAPTR.new.load('example.com. IN NAPTR 100 50 "a" "z3950+N2L+N2C" "" cidserver.example.com.')
    assert_equal 'example.com.', rr.label
    assert_equal 'NAPTR', rr.type
    assert_equal 100, rr.order
    assert_equal 50, rr.pref
    assert_equal 'a', rr.flags
    assert_equal 'z3950+N2L+N2C', rr.service
    assert_equal '', rr.regexp
    assert_equal 'cidserver.example.com.', rr.replacement

    rr = DNS::Zone::RR::NAPTR.new.load('example.com. IN NAPTR 100 60 "a" "rcds+N2C" "" cidserver.example.com.')
    assert_equal 'example.com.', rr.label
    assert_equal 'NAPTR', rr.type
    assert_equal 100, rr.order
    assert_equal 60, rr.pref
    assert_equal 'a', rr.flags
    assert_equal 'rcds+N2C', rr.service
    assert_equal '', rr.regexp
    assert_equal 'cidserver.example.com.', rr.replacement

    rr = DNS::Zone::RR::NAPTR.new.load('example.com. IN NAPTR 300 50 "b" "http+N2L+N2C+N2R" "" www.example.com.')
    assert_equal 'example.com.', rr.label
    assert_equal 'NAPTR', rr.type
    assert_equal 300, rr.order
    assert_equal 50, rr.pref
    assert_equal 'b', rr.flags
    assert_equal 'http+N2L+N2C+N2R', rr.service
    assert_equal '', rr.regexp
    assert_equal 'www.example.com.', rr.replacement

  end

end
