---
title: Ruby
weight: 90
tags:
  - ruby
  - languages
category: Languages &amp; Frameworks
redirect_from:
  - /languages/ruby/
---
We use RVM to manage different Ruby versions. We set <strong>{% default_ruby_version %}</strong> as the default version. Currently we do not load the Ruby version from your Gemfile. You can always change the Ruby version by running:

```shell
rvm use RUBY_VERSION_YOU_WANT_TO_USE
```

The following Ruby versions are preinstalled

{% ruby_versions %}

## Setting the Ruby version through a .ruby-version file
You can also use your .ruby-version file on Codeship. The .ruby-version file lives in the project root and its content is just your Ruby version, for example: `2.0.0-p195`. You can just read the ruby version to use from that file:

```shell
rvm use $(cat .ruby-version) --install
```

One use case is that you can change your Ruby version for different branches.

## Bundler
Bundler is preinstalled for all Ruby versions already included on the build VMs.

If you install a version not preinstalled on the VM already, you need to install bundler yourself by adding the following command to your setup steps

```shell
gem install bundler
```

## Nokogiri
On **Ruby 2.3 only**, Nokogiri will fail to compile with the bundled _libxml_ and _libxslt_ libraries. To install the gem you need to use the system libraries instead.

```
# add the following command before running "bundle install"
bundle config build.nokogiri --use-system-libraries
```

## Supported Test Frameworks
We support all Ruby based test frameworks from RSpec, Cucumber to Minitest or others.

## Run with bundle exec
Make sure to run your commands with `bundle exec` (e.g. `bundle exec rspec`) so all commands you run are executed with the versions of the ruby gems you configured in your Gemfile.lock

## Capybara
Capybara is supported out of the box with the selenium-webdriver , capybara-webkit or the poltergeist driver for phantomjs.

## Parallelization Gems
In addition to parallelizing explicitly [via parallel pipelines]({{ site.baseurl }}{% link _basic/getting-started/parallelci.md %}), there are a couple Rails gems that are popular ways to parallelize within your codebase.

While we do not officially support or integrate with these modules, many Codeship users find success speeding their tests up by using them. Note that it is possible for these gems to cause resource and build failure issues, as well.

- [https://github.com/grosser/parallel_tests](https://github.com/grosser/parallel_tests)
- [https://github.com/ArturT/knapsack](https://github.com/ArturT/knapsack)
