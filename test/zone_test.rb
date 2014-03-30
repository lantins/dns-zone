require 'dns/zone/test_case'

class ZoneTest < DNS::Zone::TestCase

  # example zone file, with a couple of things that could trip us up.
  ZONE_FILE_EXAMPLE =<<-EOL
$ORIGIN lividpenguin.com.
$TTL 3d
@           IN  SOA  ns0.lividpenguin.com. luke.lividpenguin.com. (
                           2013101406 ; zone serial number
                           12h        ; refresh ttl
                           15m        ; retry ttl
                           3w         ; expiry ttl
                           3h         ; minimum ttl
                         )

; a more difficult ; comment ( that is trying to break things!

@           IN  NS    ns0.lividpenguin.com.
@           IN  NS    ns1.lividpenguin.com.
@           IN  NS    ns2.lividpenguin.com.

@           IN  MX 10 mx0.lividpenguin.com.
@           IN  MX 20 mx1.lividpenguin.com.

@           IN  A     78.47.253.85
ns0         IN  A     78.47.253.85
ns0         IN  HINFO "Intel" "Ubuntu"

ns0         IN  AAAA  2a01:4f8:d12:5ca::2

foo         IN  TXT   "part1""part2"
bar         IN  TXT   ("part1 "
                       "part2 "
                       "part3")

longttl  5d IN A      10.1.2.3

cake        IN  CNAME the.cake.is.a.lie.com.
xmpp        IN  SRV 5 0 5269 xmpp-server.google.com.
@           IN  SPF "v=spf1 +mx -all"

; a record to be expanded
@           IN  NS    ns3

; a record that uses tab spaces
tabed				IN	A			10.1.2.3

EOL

  # basic zone file example
  ZONE_FILE_BASIC_EXAMPLE =<<-EOL
@ IN SOA ns0.lividpenguin.com. luke.lividpenguin.com. ( 2013101406 12h 15m 3w 3h )
@ IN NS ns0.lividpenguin.com.
@ IN A 78.47.253.85
EOL

  def test_create_new_instance
    assert DNS::Zone.new
  end

  def test_load_zone_basic
    # load zone file.
    zone = DNS::Zone.load(ZONE_FILE_BASIC_EXAMPLE)
    # dump zone file.
    dump = zone.dump
    # check input matches output.
    assert_equal ZONE_FILE_BASIC_EXAMPLE, dump, 'loaded zone file should match dumped zone file'
  end

  def test_load_zone
    # load example dns master zone file.
    zone = DNS::Zone.load(ZONE_FILE_EXAMPLE)

    # test attributes are correct.
    assert_equal '3d', zone.ttl, 'check ttl matches example input'
    assert_equal 'lividpenguin.com.', zone.origin, 'check origin matches example input'
    assert_equal 18, zone.records.length, 'we should have multiple records (including SOA)'

    #p ''
    #zone.records.each do |rec|
    #  p rec
    #end
  end

  def test_load_zone_with_empty_labels
    # basic zone file that uses empty labels (ie. use previous)
    zone_as_string =<<-EOL
@    IN A     78.47.253.85
     IN AAAA  2a01:4f8:d12:5ca::2
www  IN A     78.47.253.85
     IN AAAA  2a01:4f8:d12:5ca::2
EOL

    # load zone file.
    zone = DNS::Zone.load(zone_as_string)

    # test labels are 'inherited' from last used.
    assert_equal '@', zone.records[0].label
    assert_equal '@', zone.records[1].label, 'label should be inherited from last label used'
    assert_equal 'www', zone.records[2].label
    assert_equal 'www', zone.records[3].label, 'label should be inherited from last label used'
  end

  def test_load_zone_that_uses_tabs_rather_then_spaces
    zone_as_string =<<-EOL
*		IN	A			78.47.253.85
EOL

    # load zone file.
    zone = DNS::Zone.load(zone_as_string)

    record = zone.records[0]
    assert_equal '*', record.label
    assert_equal 'A', record.type
    assert_equal '78.47.253.85', record.address
  end

  def test_extract_entry_from_one_line
    entries = DNS::Zone.extract_entries(%Q{maiow IN TXT "purr"})
    assert_equal 1, entries.length, 'we should have 1 entry'
    assert_equal 'maiow IN TXT "purr"', entries[0], 'entry should match expected'
  end

  def test_extract_entry_should_ignore_comments
    entries = DNS::Zone.extract_entries(%Q{maiow IN TXT "purr"; this is a comment})
    assert_equal 1, entries.length, 'we should have 1 entry'
    assert_equal 'maiow IN TXT "purr"', entries[0], 'entry should match expected'
  end

  def test_extract_entry_should_ignore_empty_lines
    entries = DNS::Zone.extract_entries(%Q{\n\nmaiow IN TXT "purr";\n\n})
    assert_equal 1, entries.length, 'we should have 1 entry'
    assert_equal 'maiow IN TXT "purr"', entries[0], 'entry should match expected'
  end

  def test_extract_entry_using_parentheses_but_not_crossing_line_boundary
    entries = DNS::Zone.extract_entries(%Q{maiow  IN  TXT ("part1" "part2")})
    assert_equal 1, entries.length, 'we should have 1 entry'
    assert_equal 'maiow  IN  TXT  "part1" "part2"', entries[0], 'entry should match expected'
  end

  def test_extract_entry_crossing_line_boundary
    entries = DNS::Zone.extract_entries(%Q{maiow1  IN  TXT ("part1"\n "part2" )})
    assert_equal 1, entries.length, 'we should have 1 entry'
    assert_equal 'maiow1  IN  TXT  "part1" "part2"', entries[0], 'entry should match expected'
  end

  def test_extract_entry_soa_crossing_line_boundary
    entries = DNS::Zone.extract_entries(%Q{
@ IN  SOA  ns0.lividpenguin.com. luke.lividpenguin.com. (
 2013101406 ; zone serial number
 12h ; refresh ttl
 15m ; retry ttl
 3w  ; expiry ttl
 3h  ; minimum ttl
)})
    assert_equal 1, entries.length, 'we should have 1 entry'

    expected_soa = '@ IN  SOA  ns0.lividpenguin.com. luke.lividpenguin.com.  2013101406  12h  15m  3w  3h'
    assert_equal expected_soa, entries[0], 'entry should match expected'
  end

  def test_extract_entries_with_parentheses_crossing_multiple_line_boundaries
    entries = DNS::Zone.extract_entries(%Q{maiow1  IN  TXT (\n"part1"\n "part2"\n)})
    assert_equal 1, entries.length, 'we should have 1 entry'
    assert_equal 'maiow1  IN  TXT  "part1" "part2"', entries[0], 'entry should match expected'
  end

  def test_extract_entries_with_legal_but_crazy_parentheses_used
    entries = DNS::Zone.extract_entries(%Q{maiow IN TXT (\n(\n("part1")\n \n("part2" \n("part3"\n)\n)\n)\n)})
    assert_equal 1, entries.length, 'we should have 1 entry'
    assert_equal 'maiow IN TXT  "part1" "part2" "part3"', entries[0], 'entry should match expected'
  end

  def test_extract_entry_with_parentheses_in_character_string
    entries = DNS::Zone.extract_entries(%Q{maiow IN TXT ("purr((maiow)")})
    assert_equal 1, entries.length, 'we should have 1 entry'
    assert_equal 'maiow IN TXT "purr((maiow)"', entries[0], 'entry should match expected'
  end

end
