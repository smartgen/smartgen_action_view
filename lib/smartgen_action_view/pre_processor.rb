require 'tempfile'

module Smartgen
  module Engine
    class ActionViewPreProcessor
      include ActionViewProcessor

      attr_accessor :engine

      def process(body, metadata)
        process_template(body, metadata)
      end

      protected

        def process_by_engine(contents, metadata)
          engine.process_without_pre_processors(contents, metadata).html_safe
        end
    end
  end
end