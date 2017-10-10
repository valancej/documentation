module Jekyll
  class CategoryPage < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'categories.html')
      self.data['category'] = category
    end
  end

  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'categories'
        dir = site.config['categories_dir'] || 'categories'

        collections = site.collections.map(&:first)

        collections.each do |collection|
          site.collections[collection].docs.each do |post|
            dir_str = post.url.split("/")
            if dir_str.length >= 4
              cat = dir_str[2]
              site.pages << CategoryPage.new(site, site.source, File.join(dir, cat.downcase.gsub(' ', '-')), cat)
            end
          end
        end
      end
    end
  end
end
