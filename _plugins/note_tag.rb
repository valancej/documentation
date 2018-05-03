module Jekyll
	class NoteTag < Liquid::Block
		def initialize(tag_name, type, tokens)
			super
			@type = type.strip.downcase unless type.empty?
		end

		def render(context)
			content = super
			css_classes = "note-#{@type}" if @type

			out = <<~EOF
				<div class="note #{css_classes}">
					#{content}
				</div>
			EOF
			out
		end
	end
end

Liquid::Template.register_tag('csnote', Jekyll::NoteTag)
