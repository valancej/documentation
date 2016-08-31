FROM ruby:2.3.1-slim
MAINTAINER marko@codeship.com

ENV \
	DEBIAN_DISTRIBUTION="jessie" \
	DEBIAN_FRONTEND="noninteractive" \
	NODE_VERSION="4.x"

# basic project configuration
WORKDIR /docs
EXPOSE 4000

# System dependencies
RUN \
	apt-get update && \
	apt-get install -y --no-install-recommends \
		apt-transport-https && \
	curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
	echo "deb https://deb.nodesource.com/node_${NODE_VERSION} ${DEBIAN_DISTRIBUTION} main" > /etc/apt/sources.list.d/nodesource.list && \
	apt-get update && \
	apt-get install -y --no-install-recommends \
		build-essential \
		graphicsmagick \
		libssl1.0.0 \
		libyaml-0-2 \
		nodejs && \
	ln -s $(which nodejs) /usr/local/bin/node && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*

# NPM based dependencies
COPY package.json npm-shrinkwrap.json ./
RUN \
	npm config set "production" "true" && \
	npm config set "loglevel" "error" && \
 	npm install && \
	ln -s /docs/node_modules/gulp/bin/gulp.js /usr/local/bin/gulp

# Ruby based dependencies
COPY Gemfile Gemfile.lock ./
RUN \
	echo "gem: --no-rdoc --no-ri" >> ${HOME}/.gemrc && \
	bundle install --jobs 20 --retry 5 --without development

# Copy the complete site
COPY . ./

# Serve the site
CMD ["bundle", "exec", "jekyll", "serve", "-H", "0.0.0.0", "--incremental"]
