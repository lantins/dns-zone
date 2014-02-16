require 'dns/zone/test_case'

class ZoneTest < DNS::Zone::TestCase

  def test_create_new_instance
    assert DNS::Zone.new
  end

end
