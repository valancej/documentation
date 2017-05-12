#!/bin/bash

#
# This script is meant to be called on a Codeship SSH Debug VM.
# It will collect information to update the lists of available Ruby, PHP and
# NodeJS versions as well as installed packages.
#
# How to use this script:
# 1) Open a SSH debug build for a project and SSH into the build VM.
# 2) Run the following command:
#    \curl -sSL https://raw.githubusercontent.com/codeship/documentation/master/bin/packages.sh | bash -s
#    This will create an archive called AMI_ID.tar.gz in the current directory.
# 3) Download that archive (e.g. via scp) and extract it into the "_includes/basic/ami" directory.
# 4) Update "_data/basic.yml" with the new AMI ID and the current date.

curl -o ec2-metadata http://s3.amazonaws.com/ec2metadata/ec2-metadata
chmod u+x ./ec2-metadata
ami=$(./ec2-metadata --ami-id |  awk -F ': ' '{print $2}')

mkdir -p "${ami}"

# NodeJS versions
source ~/.nvm/nvm.sh
echo '```shell' > "${ami}/node.md"
nvm list >> "${ami}/node.md"
echo '```' >> "${ami}/node.md"

# PHP versions
echo '```shell' > "${ami}/php.md"
phpenv versions >> "${ami}/php.md"
echo '```' >> "${ami}/php.md"

# Ruby versions
echo '```shell' > "${ami}/ruby.md"
rvm list >> "${ami}/ruby.md"
echo '```' >> "${ami}/ruby.md"

# Python versions
echo '```shell' > "${ami}/python.md"
phpenv versions >> "${ami}/python.md"
echo '```' >> "${ami}/python.md"

# Packages
echo '```shell' > "${ami}/packages.md"
dpkg -l | grep '^ii' | awk '{print $2 "\t" $3}' | column -t >> "${ami}/packages.md"
echo '```' >> "${ami}/packages.md"

tar czf "${ami}.tar.gz" "./${ami}"
