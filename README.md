# [Codeship Documentation](https://codeship.com/documentation/)

[![Codeship Status for codeship/documentation](https://codeship.com/projects/0bdb0440-3af5-0133-00ea-0ebda3a33bf6/status?branch=master)](https://codeship.com/projects/102044)
[![Waffle.io Board](https://badge.waffle.io/codeship/documentation.svg?label=ready&title=Ready)](http://waffle.io/codeship/documentation)
[![Dependency Status](https://gemnasium.com/codeship/documentation.svg)](https://gemnasium.com/codeship/documentation)
[![License](http://img.shields.io/:license-mit-blue.svg)](https://github.com/codeship/documentation/blob/master/LICENSE.md)

## Contributing

We are happy to get feedback on our documentation or accept PRs from you. If you submit a PR or open a ticket, please read our [contributing guidelines](CONTRIBUTING.md) and the [code of conduct](CODE_OF_CONDUCT.md) first.

## Getting Started

### Setup

To work on the project, you need to clone the repository

```bash
git clone git@github.com:codeship/documentation.git
cd documentation
```

If you have Docker installed, we'd recommend using Docker for running & building the documentation.

First build the container and save it as a tagged image via  

```bash
docker build --tag documentation .
```

You can then run commands via that container. By default it will build the site and start the Jekyll development server.

```bash
docker run -it -p 4000:4000 -v $(pwd):/docs documentation
```

To access the site open http://IP_OF_YOUR_DOCKER_SERVER:4000 in your browser.

## Development

### Updating dependencies

To update Rubygem based dependencies make sure the specifications in the `Gemfile` are configured accordingly and then run

```bash
docker run -it -v $(pwd):/docs documentation bundle update
```

For NPM based dependencies run the following two commands

```bash
docker run -it -v $(pwd):/docs documentation npm update && npm shrinkwrap
```

### Linting

#### SCSS

SCSS files are automatically linted using [scss-lint](https://github.com/causes/scss-lint). To run it execute the following command

```bash
docker run -it -v $(pwd):/docs documentation bundle exec scss-lint
```

It's configured in [.scss-lint.yml](.scss-lint.yml) and the default configuration is [available online](https://github.com/causes/scss-lint/blob/master/config/default.yml) as well.

#### JSON

```bash
docker run -it -v $(pwd):/docs documentation gulp lint
```

## Markup

### Table of contents

If you want to include a table of contents, include the following snippet in the markdown file

```md
* include a table of contents
{:toc}
```

### URL Helpers
#### Tags

Generate a URL for the specified tag (_database_ in the example below). This is also available as a filter to be used with a variable (_tag_ in the example).

```
{% tag_url databases %}
{{ tag | tag_url }}
```

generate the output like the following (depending on configuration values)

```
/tags/databases/
```

#### Man Pages

Link to a specific Ubuntu man page. This currently defaults to the Ubuntu Trusty version.

```
{% man_url formatdb %}
```

generates the following output

```
http://manpages.ubuntu.com/manpages/trusty/en/man1/formatdb.1.html
```
