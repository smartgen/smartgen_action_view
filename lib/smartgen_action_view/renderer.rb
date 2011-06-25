module Smartgen
  module Renderer
    # A renderer that uses ActionView to render markup files.
    class ActionView
      module Helper
        def markup_file
          @markup_file
        end

        def markup_file=(markup_file)
          @markup_file = markup_file
        end

        def metadata
          @metadata
        end

        def metadata=(metadata)
          @metadata = metadata
        end
      end

      # Renders the markup file using the given layout.
      #
      # It exposes +markup_file+ variable and its +metadata+ to the ActionView layout.
      def render(layout, markup_file, metadata=Smartgen::ObjectHash.new)
        view = ::ActionView::Base.new(source_dir(markup_file))

        view.extend(Helper)
        view.markup_file = markup_file
        view.metadata = metadata

        setup_content_for_with(view)

        view.render(:layout => layout, :text => markup_file.contents)
      end
      
      private

        def source_dir(markup_file)
          File.dirname(markup_file.path)
        end

        def setup_content_for_with(view)
          if view.metadata[:content_for]
            view.metadata[:content_for].each do |name, contents|
              view.content_for(name.to_sym) { contents }
            end
          end
        end
    end
  end
end