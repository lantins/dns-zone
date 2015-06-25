require 'dns/zone/test_case'

class RR_NSEC3PARAM_Test < DNS::Zone::TestCase

  def test_build_rr__nsec3param
    rr = DNS::Zone::RR::NSEC3PARAM.new
    rr.label = 'foo.example.com.'

    rr.algorithm = 1
    rr.flags = 0
    rr.iterations = 12
    rr.salt = 'aabbccdd'

    assert_equal "foo.example.com. IN NSEC3PARAM 1 0 12 aabbccdd", rr.dump

  end

  def test_load_rr__nsec3param
    rr = DNS::Zone::RR::NSEC3PARAM.new.load("foo.example.com. IN NSEC3PARAM 1 0 12 aabbccdd")
    assert_equal 'foo.example.com.', rr.label
    assert_equal 'NSEC3PARAM', rr.type

    assert_equal 1, rr.algorithm
    assert_equal 0, rr.flags
    assert_equal 12, rr.iterations
    assert_equal 'aabbccdd', rr.salt
  end

end
