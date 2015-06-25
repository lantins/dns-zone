require 'dns/zone/test_case'

class RR_NSEC3_Test < DNS::Zone::TestCase

  def test_build_rr__nsec3
    rr = DNS::Zone::RR::NSEC3.new
    rr.label = 'foo.example.com.'

    rr.algorithm = 1
    rr.flags = 0
    rr.iterations = 12
    rr.salt = 'aabbccdd'
    rr.next_hashed_owner_name = 'ji6neoaepv8b5o6k4ev33abha8ht9fgc'
    rr.rrset_types = 'A AAAA'

    assert_equal "foo.example.com. IN NSEC3 1 0 12 aabbccdd ji6neoaepv8b5o6k4ev33abha8ht9fgc A AAAA", rr.dump

  end

  def test_load_rr__nsec3
    rr = DNS::Zone::RR::NSEC3.new.load("foo.example.com. IN NSEC3 1 0 12 aabbccdd ji6neoaepv8b5o6k4ev33abha8ht9fgc A AAAA")
    assert_equal 'foo.example.com.', rr.label
    assert_equal 'NSEC3', rr.type

    assert_equal 1, rr.algorithm
    assert_equal 0, rr.flags
    assert_equal 12, rr.iterations
    assert_equal 'aabbccdd', rr.salt
    assert_equal 'ji6neoaepv8b5o6k4ev33abha8ht9fgc', rr.next_hashed_owner_name
    assert_equal 'A AAAA', rr.rrset_types
  end

end
