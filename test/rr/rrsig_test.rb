require 'dns/zone/test_case'

class RR_RRSIG_Test < DNS::Zone::TestCase

  TEST_SIGNATURE = 'oJB1W6WNGv+ldvQ3WDG0MQkg5IEhjRip8WTrPYGv07h108dUKGMeDPKijVCHX3DDKdfb+v6oB9wfuh3DTJXUAfI/M0zmO/zz8bW0Rznl8O3tGNazPwQKkRN20XPXV6nwwfoXmJQbsLNrLfkGJ5D6fwFm8nN+6pBzeDQfsS3Ap3o='

  def test_build_rr__rrsig
    rr = DNS::Zone::RR::RRSIG.new
    rr.label = 'host.example.com.'
    rr.type_covered = 'A'
    rr.algorithm = 5
    rr.labels = 3
    rr.original_ttl = 86400
    rr.signature_expiration = 20030322173103
    rr.signature_inception = 20030220173103
    rr.key_tag = 2642
    rr.signer = 'example.com.'
    rr.signature = TEST_SIGNATURE

    assert_equal "host.example.com. IN RRSIG A 5 3 86400 20030322173103 20030220173103 2642 example.com. #{TEST_SIGNATURE}", rr.dump

  end

  def test_load_rr__rrsig
    rr = DNS::Zone::RR::RRSIG.new.load("host.example.com. IN RRSIG A 5 3 86400 20030322173103 20030220173103 2642 example.com. #{TEST_SIGNATURE}")
    assert_equal 'host.example.com.', rr.label
    assert_equal 'RRSIG', rr.type

    assert_equal 'A', rr.type_covered
    assert_equal 5, rr.algorithm
    assert_equal 3, rr.labels
    assert_equal 86400, rr.original_ttl
    assert_equal 20030322173103, rr.signature_expiration
    assert_equal 20030220173103, rr.signature_inception
    assert_equal 2642, rr.key_tag
    assert_equal 'example.com.', rr.signer
    assert_equal TEST_SIGNATURE, rr.signature
  end

end
