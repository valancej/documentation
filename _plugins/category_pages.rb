module Jekyll
  class CategoryPage < Page
    def initialize(site, base, dir, category, documents)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'categories.html')
      self.data['category'] = category
			self.data['documents'] = documents
    end
  end

  class CategoryPageGenerator < Generator
    safe true
		@@categories = {}

		def generate(site)
			if site.layouts.key? 'categories'
				dir = site.config['categories_dir'] || 'categories'
				site.collections.each do |name, collection|
					collection.docs.each do |document|
						next unless document.data['categories']
						document.data['categories'].each { |category| collect_document(category, document) }
					end
				end

				@@categories.each do |category, documents|
					site.pages << CategoryPage.new(site, site.source, File.join(dir, category.downcase.gsub(' ', '-')), category, documents)
				end
			end
		end

		def collect_document(category, document)
			category = category.downcase
			@@categories[category] = [] unless @@categories.has_key?(category)
			@@categories[category] << document
		end
	end
end
