require 'dns/zone/test_case'

class RRTest < DNS::Zone::TestCase

  def test_load_ignores_comments
    rr = DNS::Zone::RR.load('; comment lines are ignored')
    assert_nil rr, 'should be nil when its a comment line'
  end

  def test_load_ignores_unparsable_input
    rr = DNS::Zone::RR.load('invalid input should not be parsed')
    assert_nil rr, 'should be nil when input cant be parsed at all'
  end

  def test_load_a_rr
    rr = DNS::Zone::RR.load('www IN A 10.2.3.1')
    assert_instance_of DNS::Zone::RR::A, rr, 'should be instance of A RR'
    assert_equal 'www', rr.label
    assert_equal 'A', rr.type
    assert_equal '10.2.3.1', rr.address
  end

  def test_load_txt_rr
    rr = DNS::Zone::RR.load('mytxt IN TXT "test text"')
    assert_instance_of DNS::Zone::RR::TXT, rr, 'should be instance of TXT RR'
    assert_equal 'mytxt', rr.label
    assert_equal 'TXT', rr.type
    assert_equal 'test text', rr.text
  end

  def test_load_a_rr_with_options_hash
    rr = DNS::Zone::RR.load(' IN A 10.2.3.1', { last_label: 'www' })
    assert_equal 'www', rr.label

    rr = DNS::Zone::RR.load('blog IN A 10.2.3.1', { last_label: 'www' })
    assert_equal 'blog', rr.label

    rr = DNS::Zone::RR.load('@ IN A 10.2.3.1', { last_label: 'mail' })
    assert_equal '@', rr.label
  end

end
