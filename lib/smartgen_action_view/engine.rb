module Smartgen
  module Engine
    class ActionView < Base
      include ActionViewProcessor

      protected
        def parse(body, metadata)
          process_template(body, metadata)
        end

        def extensions
          @extensions ||= ['.erb']
        end

        def process_by_engine(contents, metadata)
          process_without_pre_processors(contents, metadata).html_safe
        end
    end
  end
end