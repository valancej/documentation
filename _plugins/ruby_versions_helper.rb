require 'open-uri'

module RubyVersionsHelper
  def get_all_ruby_versions
    [get_default_ruby_version] + ['jruby', 'manual', 'mri'].map { |type| get_ruby_versions(type) }.flatten
  end

  def get_default_ruby_version
    lines = get_builds_ruby_file('default/version')
    raise ArgumentError.new("Expected default version file to be one line") unless lines.size == 1
    split = lines.first.split('=')
    raise ArgumentEror.new("Expected = sign to split default version file") unless split.size == 2
    split[1]
  end

  def get_ruby_versions(type)
    get_builds_ruby_file("#{type}/versions")
  end

  def get_builds_ruby_file(relative_path)
    URI.parse("https://s3.amazonaws.com/codeship-checkbot/builds/ruby/#{relative_path}").read.split("\n")
  end
end
