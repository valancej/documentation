IMAGE_NAME = 'codeship/documentation'

desc "Build the #{IMAGE_NAME} image"
task :build do
	sh "docker build --tag #{IMAGE_NAME} ."
end

desc 'Run the development server'
task :serve do
	sh "docker run -it --rm -p 4000:4000 -v $(pwd):/docs #{IMAGE_NAME}"
end

desc 'Run tests'
task :test do
	sh "jet steps"
end

desc 'Run arbitrary commands in the Docker container'
task :run, [:command ] do |t, args|
	sh "docker run -it --rm -p 4000:4000 -v $(pwd):/docs #{IMAGE_NAME} #{args.command}"
end

desc 'Update Ruby and NodeJS based dependencies'
task update: %w[update:image build update:rubygems update:yarn]
namespace :update do
	desc 'Update the base image'
	task :image do
		File.foreach('Dockerfile'){ |line|
			next unless line.start_with? 'FROM'
			image = line.split(' ')[1]
			sh "docker pull #{image}"
		}
	end

	desc 'Update Ruby based dependencies'
	task rubygems: %w[update:image build] do
		sh "docker run -it --rm -v $(pwd):/docs #{IMAGE_NAME} bundle update"
	end

	desc 'Update NodeJS based dependencies'
	task yarn: %w[update:image build] do
		sh "docker run -it --rm -v $(pwd):/docs #{IMAGE_NAME} yarn upgrade"
	end
end

desc "Run Linters"
task lint: %w[lint:scss lint:json lint:jekyll]
namespace :lint do
	desc 'Run SCSS linter'
	task :scss do
		sh "docker run -it --rm -v $(pwd):/docs #{IMAGE_NAME} bundle exec scss-lint"
	end

	desc 'Run JSON linter'
	task :json do
		sh "docker run -it --rm -v $(pwd):/docs #{IMAGE_NAME} gulp lint"
	end

	desc 'Run Jekyll configuration linter'
	task :jekyll do
		sh "docker run -it --rm -v $(pwd):/docs #{IMAGE_NAME} bundle exec jekyll doctor"
	end
end
