---
title: Integrating Codeship With Coveralls for Code Coverage Reports
shortTitle: Using Coveralls For Code Coverage
tags:
  - analytics
  - code-coverage
  - coverage
  - reports
  - reporting
  - continuous integration
  - integrations
menus:
  general/integrations:
    title: Using Coveralls
    weight: 2
redirect_from:
  - /basic/continuous-integration/coveralls/
  - /pro/continuous-integration/coveralls-docker/
  - /analytics/coveralls/
  - /classic/getting-started/coveralls/
  - /basic/analytics/coveralls/
---

* include a table of contents
{:toc}

## About Coveralls

Coveralls is an automated code coverage service. Starting with Coveralls and Codeship is fast and easy. [Their documentation](https://coveralls.zendesk.com/hc/en-us/categories/200131159-Documentation) does a great job of providing more information, in addition to the setup instructions below.

### Coveralls Discount Code

Thanks to our partnership with Coveralls we can provide a 25% Discount for 3 months. Use the code **"coverallslovescodeship"** and [get started right away](https://coveralls.io/).

### Setup For Other Languages

Coveralls supports a lot of other languages. Check out their fantastic [documentation](https://coveralls.io/docs/supported_continuous_integration).

## Codeship Pro

### Setting Your Variables

To start, you need to add your Coveralls repo token to the [encrypted environment variables]({{ site.baseurl }}{% link _pro/builds-and-configuration/environment-variables.md %}) that you encrypt and include in your [codeship-services.yml file]({{ site.baseurl }}{% link _pro/builds-and-configuration/services.md %}).

### Coveralls Gem

Next, you'll want to either manually install the Coveralls Gem in your Dockerfile, or add it to the Gemfile that you install your dependencies from in your Docker image build.

```
gem 'coveralls', require: false
```

**Note** that this will require you to be building an image that contains both Ruby and Rubygems. If the image does not contain both of these, you will be unable to install the necessary `coveralls` gem.

### Project Configuration

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

## Codeship Basic

### Setting Your Variables

To start, you need to add your Coveralls repo token to a `.coveralls.yml` file to your codebase that contains your Coveralls key:

```
repo_token: YOUR_COVERALLS_TOKEN
```

It is also possible to set this in the [environment variables]({{ site.baseurl }}{% link _basic/builds-and-configuration/set-environment-variables.md %}) for your project.

You can do this by navigating to _Project Settings_ and then clicking on the _Environment_ tab.

### Coveralls Gem

Next, you'll need to require the Gem in your Gemfile.

```
gem 'coveralls', require: false
```

### Project Configuration

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

Then you need to add a rake task that pushes your coverage report as soon as your build is finished.

```ruby
require 'coveralls/rake/task'
Coveralls::RakeTask.new
```

### Pushing Data

To push the data to Coveralls, add the following after your [test commands]({{ site.baseurl }}{% link _basic/quickstart/getting-started.md %}) on Codeship:

```ruby
bundle exec rake coveralls:push
```
