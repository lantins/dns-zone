require 'dns/zone/test_case'

class RR_DNSKEY_Test < DNS::Zone::TestCase

  # FIXME (lantins): algorithm can be integer _or_ mnemonic!

  def test_build_rr__dnskey
    rr = DNS::Zone::RR::DNSKEY.new
    rr.label = 'example.com.'
    rr.flags = 256
    rr.protocol = 3
    rr.algorithm = 5
    rr.key = 'AQPSKmynfzW4kyBv015MUG2DeIQ30PY1kxkmvHjcZc8no5CptLr3buXA10hWqTkF7H6RfoRqXQeogmMHfpftf6zMv1LyBUgia7za6ZEzOJBOztyvhjLTpPSEDhm2SNKLijfUppn1UaNvv4w=='

    assert_equal 'example.com. 86400 IN DNSKEY 256 3 5 AQPSKmynfzW4kyBv015MUG2DeIQ30PY1kxkmvHjcZc8no5CptLr3buXA10hWqTkF7H6RfoRqXQeogmMHfpftf6zMv1LyBUgia7za6ZEzOJBOztyvhjLTpPSEDhm2SNKLijfUppn1UaNvv4w==', rr.dump
  end

  def test_load_rr__dnskey
    example_dnskey =<<EOL
example.com. 86400 IN DNSKEY 256 3 5 ( AQPSKmynfzW4kyBv015MUG2DeIQ3
                                       Cbl+BBZH4b/0PY1kxkmvHjcZc8no
                                       kfzj31GajIQKY+5CptLr3buXA10h
                                       WqTkF7H6RfoRqXQeogmMHfpftf6z
                                       Mv1LyBUgia7za6ZEzOJBOztyvhjL
                                       742iU/TpPSEDhm2SNKLijfUppn1U
                                       aNvv4w==  )
EOL

    rr = DNS::Zone::RR::DNSKEY.new.load(example_dnskey)
    assert_equal 'example.com.', rr.label
    assert_equal 'DNSKEY', rr.type
    assert_equal 256, rr.flags
    assert_equal 3, rr.protocol
    assert_equal 5, rr.algorithm
    assert_equal 'AQPSKmynfzW4kyBv015MUG2DeIQ30PY1kxkmvHjcZc8no5CptLr3buXA10hWqTkF7H6RfoRqXQeogmMHfpftf6zMv1LyBUgia7za6ZEzOJBOztyvhjLTpPSEDhm2SNKLijfUppn1UaNvv4w==', rr.fingerprint
  end

end
