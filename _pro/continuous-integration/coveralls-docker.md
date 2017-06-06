---
title: Integrating Codeship Pro With Coveralls for Code Coverage Reports
layout: page
tags:
  - analytics
  - integrations
  - code coverage
  - browsers
menus:
  pro/ci:
    title: Git Submodules
    weight: 4
redirect_from:
  - /analytics/coveralls/
  - /classic/getting-started/coveralls/
  - /basic/analytics/coveralls/
---

* include a table of contents
{:toc}

## Coveralls Discount Code

Thanks to our partnership with Coveralls we can provide a 25% Discount for 3 months. Use the code **"coverallslovescodeship"** and [get started right away](https://coveralls.io/).

## Setting Up Coveralls

### Setting Your Coveralls Variables

Starting with Coveralls and Codeship is easy. [Their docs](https://coveralls.io) do a great job of guiding you, but the first step is to add your Coveralls repo token to the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you define in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Coveralls Gem

Next, you'll want to either manually install the Coveralls Gem in your Dockerfile, or add it to the Gemfile that you install your dependencies from in your Docker image build.

```
gem 'coveralls', require: false
```

**Note** that this will require you to be building an image that contains both Ruby and Rubygems. If the image does not contain both of these, you will be unable to install the necessary `coveralls` gem.

### Application Configuration

Now, you'll need to put the Covealls initializers into your `spec_helper.rb` or `env.rb` file, depending on which framework you use.

```ruby
require 'coveralls'
Coveralls.wear!
```

If you want to combine the coverage data from different frameworks, add the following to your `spec_helper.rb` or `env.rb`.

```ruby
# Coveralls with Rspec and Cucumber
require 'coveralls'
Coveralls.wear_merged!
SimpleCov.merge_timeout 3600

# MAKING SURE SIMPLECOV WORKS WITH THE PARALLEL_TESTS GEM
SimpleCov.command_name "RSpec/Cucumber:#{Process.pid.to_s}#{ENV['TEST_ENV_NUMBER']}"
```

Finally, you'll you need to add a rake task that pushes your coverage report as soon as your build is finished.

```ruby
require 'coveralls/rake/task'
Coveralls::RakeTask.new
```

### Pushing Data

The last thing you'll need to be sure to do is to actually push your data out to Coveralls. This will happen with a command either run directly or inside of a script in your [codeship-steps.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/steps.md %}):


```bash
- name: coveralls_push
  service: your_service
  command: bundle exec rake coveralls:push
```

### Setup for other languages

Coveralls supports a lot of other languages. Check out their fantastic [documentation](https://coveralls.io/docs/supported_continuous_integration).
