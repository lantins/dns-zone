# Run minitest suite
guard :minitest do
  watch(%r{^dns-zone\.gemspec})                  { 'all' }
  watch(%r{^lib/dns/(.*)\.rb})                   { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^lib/dns/zone/test_case\.rb})         { 'all' }
  watch(%r{^lib/dns/zone/(.*/)?([^/]+)\.rb})     { |m| "test/#{m[1]}#{m[2]}_test.rb" }
  watch(%r{^test/(.*/)*(.*)_test\.rb})
end

# Run `bundle update|install` when gem files altered.
guard :bundler do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end
