FROM ruby:2.3.1-slim
MAINTAINER marko@codeship.com

# workdir configuration
WORKDIR /docs

# Install required dependencies and clean up after the build.
COPY Gemfile Gemfile.lock package.json npm-shrinkwrap.json ./
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
	apt-get update && apt-get install -y --no-install-recommends \
		build-essential \
		libssl1.0.0 \
		libyaml-0-2 \
		nodejs && \
	ln -s $(which nodejs) /usr/local/bin/node && \
	npm config set "production" "true" && \
	npm config set "loglevel" "error" && \
	npm install && \
	ln -s /docs/node_modules/gulp/bin/gulp.js /usr/local/bin/gulp && \
	echo "gem: --no-rdoc --no-ri" >> ${HOME}/.gemrc && \
	bundle install --jobs 20 --retry 5 --without development && \
	apt-get clean -y && \
	apt-get purge -y --auto-remove build-essential && \
	rm -rf ${HOME}/.npm/* && \
	rm -rf /usr/local/bundle/gems/*/cache/*.gem && \
	rm -rf /var/lib/apt/lists/*

# Add the source for the site
COPY . ./
