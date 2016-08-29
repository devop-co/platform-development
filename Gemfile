bundler_version=File.read('.bundler-version').chomp
if Gem::Version.new(Bundler::VERSION) < Gem::Version.new(bundler_version)
  puts "Upgrading Bundler"
  puts `gem install bundler -v '~> #{bundler_version}'`
  abort "Bundler version #{bundler_version} upgraded, please bundle run again"
end

source 'http://rubygems.org'
