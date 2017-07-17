# A sample Gemfile
source "https://rubygems.org"
ruby "2.4.1"

# work around an issue with jekyll-redirect-from, see the following ticket for
# more information:
# https://github.com/jekyll/jekyll-redirect-from/issues/150
Encoding.default_external = Encoding::UTF_8

gem 'rake', '~>12.0.0'
# Jekyll 3.5.0 includes a bug with Liquid Plugins, see
# https://github.com/jekyll/jekyll/issues/6181 for the bug report. We'll have to
# wait for 3.5.1 to upgrade.
gem 'jekyll', '~> 3.4.5'
gem 'sass', '~> 3.4.25'

# Jekyll plugins
gem 'jekyll-coffeescript', '~> 1.0.2'
gem 'jekyll-seo-tag', '~> 2.2.3'
gem 'jekyll-sitemap', '~> 1.1.1'
gem 'jekyll-redirect-from', '~> 0.12.1'
gem 'jekyll-menus', '~> 0.6.0'

group :test do
  gem 'scss_lint', '~> 0.54.0'
end
