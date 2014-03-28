require 'dns/zone/test_case'

class RR_PTR_Test < DNS::Zone::TestCase

  def test_build_rr__ptr
    rr = DNS::Zone::RR::PTR.new
    rr.label = '69'
    rr.name = 'mx0.lividpenguin.com.'
    assert_equal '69 IN PTR mx0.lividpenguin.com.', rr.dump
  end

  def test_load_rr__ptr
    rr = DNS::Zone::RR::PTR.new.load('69 IN PTR mx0.lividpenguin.com.')
    assert_equal '69', rr.label
    assert_equal 'PTR', rr.type
    assert_equal 'mx0.lividpenguin.com.', rr.name
  end

end
