require 'dns/zone/test_case'

class RR_CDS_Test < DNS::Zone::TestCase

  TEST_DIGEST = '2BB183AF5F22588179A53B0A98631FAD1A292118'

  def test_build_rr__cds
    rr = DNS::Zone::RR::CDS.new
    rr.label = 'dskey.example.com.'
    rr.key_tag = 60485
    rr.algorithm = 5
    rr.digest_type = 1
    rr.digest = TEST_DIGEST

    assert_equal "dskey.example.com. IN CDS 60485 5 1 #{TEST_DIGEST}", rr.dump
  end

  def test_load_rr__cds
    rr = DNS::Zone::RR::CDS.new.load("dskey.example.com. IN CDS 60485 5 1 #{TEST_DIGEST}")
    assert_equal 'dskey.example.com.', rr.label
    assert_equal 'CDS', rr.type
    assert_equal 60485, rr.key_tag
    assert_equal 5, rr.algorithm
    assert_equal 1, rr.digest_type
    assert_equal TEST_DIGEST, rr.digest
  end

end
