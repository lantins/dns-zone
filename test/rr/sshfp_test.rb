require 'dns/zone/test_case'

class RR_SSHFP_Test < DNS::Zone::TestCase

  def test_build_rr__sshfp
    rr = DNS::Zone::RR::SSHFP.new
    rr.label = 'host.example.'
    rr.algorithm_number = 2
    rr.fingerprint_type = 1
    rr.fingerprint = '123456789abcdef67890123456789abcdef67890'

    assert_equal 'host.example. IN SSHFP 2 1 123456789abcdef67890123456789abcdef67890', rr.dump
  end

  def test_load_rr__sshfp
    rr = DNS::Zone::RR::SSHFP.new.load('host.example. IN SSHFP 2 1 123456789abcdef67890123456789abcdef67890')
    assert_equal 'host.example.', rr.label
    assert_equal 'SSHFP', rr.type
    assert_equal 2, rr.algorithm_number
    assert_equal 1, rr.fingerprint_type
    assert_equal '123456789abcdef67890123456789abcdef67890', rr.fingerprint
  end

end
