require 'dns/zone/test_case'

class RR_CDNSKEY_Test < DNS::Zone::TestCase

  # FIXME (lantins): algorithm can be integer _or_ mnemonic!

  TEST_KEY = 'AQPSKmynfzW4kyBv015MUG2DeIQ3Cbl+BBZH4b/0PY1kxkmvHjcZc8nokfzj31GajIQKY+5CptLr3buXA10hWqTkF7H6RfoRqXQeogmMHfpftf6zMv1LyBUgia7za6ZEzOJBOztyvhjL742iU/TpPSEDhm2SNKLijfUppn1UaNvv4w=='

  def test_build_rr__cdnskey
    rr = DNS::Zone::RR::CDNSKEY.new
    rr.label = 'example.com.'
    rr.ttl = 86400
    rr.flags = 256
    rr.protocol = 3
    rr.algorithm = 5
    rr.key = TEST_KEY

    assert_equal "example.com. 86400 IN CDNSKEY 256 3 5 #{TEST_KEY}", rr.dump
  end

  def test_load_rr__cdnskey
    rr = DNS::Zone::RR::CDNSKEY.new.load("example.com. IN CDNSKEY 256 3 5 #{TEST_KEY}")
    assert_equal 'example.com.', rr.label
    assert_equal 'CDNSKEY', rr.type
    assert_equal 256, rr.flags
    assert_equal 3, rr.protocol
    assert_equal 5, rr.algorithm
    assert_equal TEST_KEY, rr.key
  end

end
