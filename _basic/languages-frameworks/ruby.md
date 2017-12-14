---
title: Using Ruby In CI/CD with Codeship Basic
shortTitle: Ruby
menus:
  basic/languages:
    title: Ruby
    weight: 1
tags:
  - ruby
  - jruby
  - languages
  - rails
  - sinatra
  - rvm
  - bundler
categories:
  - Languages And Frameworks
redirect_from:
  - /languages/ruby/
  - /general/projects/could-not-find-gemname-in-any-of-the-sources/
---

* include a table of contents
{:toc}

## Versions And Setup

### RVM
We use [RVM](https://rvm.io) to manage different [Ruby](https://www.ruby-lang.org/en) and [JRuby](http://jruby.org) versions. We set **{{ site.data.basic.defaults.ruby }}** as the default version. Currently we do not automatically load the Ruby version from your Gemfile. You can always change the Ruby version by running:

```shell
rvm use RUBY_VERSION_YOU_WANT_TO_USE
```

The following Ruby versions are preinstalled:

{% include basic/ami/{{ site.data.basic.ami_id }}/ruby.md %}

### Using a .ruby-version file
You can also use your `.ruby-version` file on Codeship. The `.ruby-version` file lives in the project root and its content is just your Ruby version, for example: `2.4.2`. You can read the Ruby version to use from that file:

```shell
rvm use $(cat .ruby-version) --install
```

One use case is that you can change your Ruby version for different branches.

## Dependencies

You can install dependencies using [bundler](http://bundler.io) in your [setup commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}).

For example:

```shell
gem install bundler
bundle install
```

### Dependency Cache

Codeship automatically configures bundler to use the `$HOME/cache/bundler` directory, which we save between builds to optimize build performance. You can [read this article to learn more]({{ site.baseurl }}{% link _basic/builds-and-configuration/dependency-cache.md %}) about the dependency cache and how to clear it.

## Frameworks And Testing

Our Ruby support includes Ruby itself, [Rails](http://rubyonrails.org), [Sinatra](http://sinatrarb.com) and most other frameworks that do not require root-access for customized system configuration.

We also support all Ruby based test frameworks like RSpec, Cucumber and Minitest.

Capybara is also [supported out of the box]({{ site.baseurl }}{% link _basic/continuous-integration/browser-testing.md %}) with the selenium-webdriver, capybara-webkit or the poltergeist driver for PhantomJS.

## Parallel Testing

If you are running [parallel test pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/parallel-tests.md %}), you will want to separate your RSpec tests into groups and call a group specifically in each pipeline. For instance:

**Pipeline 1**:
```shell
rspec spec/spec_1
```

**Pipeline 2**:
```shell
rspec spec/spec_2
```

### Parallelization Gems

In addition to parallelizing your tests explicitly [with parallel pipelines]({{ site.baseurl }}{% link _basic/builds-and-configuration/parallel-tests.md %}), there are a couple Rails gems that are popular ways to parallelize within your codebase.

While we do not officially support or integrate with these modules, many Codeship users find success speeding their tests up by using them. Note that it is possible for these gems to cause resource and build failure issues.

- [https://github.com/grosser/parallel_tests](https://github.com/grosser/parallel_tests)
- [https://github.com/ArturT/knapsack](https://github.com/ArturT/knapsack)


## Notes And Known Issues

### Nokogiri
On **Ruby 2.3 only**, Nokogiri will fail to compile with the bundled _libxml_ and _libxslt_ libraries. To install the gem you need to use the system libraries instead.

```shell
# Add the following command before running "bundle install"
bundle config build.nokogiri --use-system-libraries
```

### Run With Bundle Exec

Make sure to run your commands with `bundle exec` (e.g. `bundle exec rspec`) so all commands you run are executed with the versions of the Ruby gems you configured in your Gemfile.lock.

### Can Not Find Gem In Sources

Sometimes you might see errors like the following:

```
Could not find safe_yaml-0.9.2 in any of the sources
```

Please make sure the version of the gem you want to install wasn't removed from [RubyGems](https://rubygems.org/).

### RVM Requires Curl

Any Ruby version you might need should already be installed by default, however if you are trying to manually install a version with RVM you may encounter the following error:

```
RVM requires 'curl'. Install 'curl' first and try again.
```

This error typically occurs when the NPM package [node-which](https://github.com/npm/node-which) is installed. You can check if it is present in the build with:

```
$ which which
node_modules/.bin/which
```

To workaround this, temporarily remove the NPM version of `which`, then run your `rvm` command. After that completes you can let the package reinstall with either `npm install` or `yarn install`. To remove it, add this command at the start of your _Setup Steps_:

```
rm -f node_modules/.bin/which
```
