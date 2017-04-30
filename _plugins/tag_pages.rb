module Jekyll
  class TagPage < Page
    def initialize(site, base, dir, tag, documents)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tags.html')
      self.data['tag'] = tag
			self.data['documents'] = documents
    end
  end

  class TagPageGenerator < Generator
    safe true
		@@tags = {}

    def generate(site)
      if site.layouts.key? 'tags'
        dir = site.config['tags_dir'] || 'tags'
				site.collections.each do |name, collection|
					collection.docs.each do |document|
						next unless document.data['tags']
						document.data['tags'].each { |tag| collect_document(tag, document) }
					end
				end

				@@tags.each {|tag, documents|
					site.pages << TagPage.new(site, site.source, File.join(dir, tag.downcase.gsub(' ', '-')), tag, documents)
				}
      end
    end

		def collect_document(tag, document)
			tag = tag.downcase
			@@tags[tag] = [] unless @@tags.has_key?(tag)
			@@tags[tag] << document
		end
  end

  class TagUrl < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @tag = text.strip
    end

    def render(context)
      site = context.registers[:site]
      tags_dir = site.config['tags_dir'] || 'tags'
      [ site.baseurl, tags_dir, @tag.downcase.gsub(' ', '-'), '' ].join('/')
    end
  end

  module TagFilters
    def tag_url(input)
      site = @context.registers[:site]
      tags_dir = site.config['tags_dir'] || 'tags'
      [ site.baseurl, tags_dir, input.downcase.gsub(' ', '-'), '' ].join('/')
    end
  end
end

Liquid::Template.register_filter(Jekyll::TagFilters)
Liquid::Template.register_tag('tag_url', Jekyll::TagUrl)
