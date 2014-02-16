require 'dns/zone/test_case'

class ZoneTest < DNS::Zone::TestCase

  ZONE_EXAMPLE_SIMPLE =<<-EOL
$ORIGIN lividpenguin.com.
$TTL 3d
@  IN  SOA  ns0.lividpenguin.com. luke.lividpenguin.com. (2013101406 12h 15m 3w 3h)

@  IN  NS   ns0.lividpenguin.com.
@  IN  NS   ns1.lividpenguin.com.
@  IN  NS   ns2.lividpenguin.com.

@  IN  A    77.75.105.197
@  IN  AAAA 2a01:348::6:4d4b:69c5:0:1
EOL

  def test_create_new_instance
    assert DNS::Zone.new
  end

  def test_load_simple_zone
    zone = DNS::Zone.load(ZONE_EXAMPLE_SIMPLE)
    assert_equal '3d', zone.ttl, 'check ttl matches example input'
    assert_equal 'lividpenguin.com.', zone.origin, 'check origin matches example input'
  end

end
