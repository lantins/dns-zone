require 'dns/zone/test_case'

class VersionTest < DNS::Zone::TestCase
  def test_should_have_a_version
    assert DNS::Zone::Version, 'unable to access the version number'
  end
end
