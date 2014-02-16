require 'dns/zone/test_case'

class RR_TXT_Test < DNS::Zone::TestCase

  def test_build_rr__txt
    rr = DNS::Zone::RR::TXT.new

    # ensure we can set text parameter
    rr.text = 'test text'
    assert_equal '@ IN TXT "test text"', rr.to_s

    # with a label set
    rr.label = 'labelname'
    assert_equal 'labelname IN TXT "test text"', rr.to_s

    # with a ttl
    rr.ttl = '2w'
    assert_equal 'labelname 2w IN TXT "test text"', rr.to_s
  end

  def test_load
    rr = DNS::Zone::RR::TXT.new.load('txtrecord IN TXT "test text"')
    assert_equal 'txtrecord', rr.label
    assert_equal 'IN', rr.klass
    assert_equal 'TXT', rr.type
    assert_equal 'test text', rr.text
  end

end
