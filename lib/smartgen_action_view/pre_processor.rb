require 'tempfile'

module Smartgen
  module Engine
    class ActionViewPreProcessor
      attr_accessor :engine
      attr_accessor :tempfile

      def process(body, metadata)
        create_tempfile_with(body)
        view = ::ActionView::Base.new File.dirname(tempfile.path)
        result = view.render :file => tempfile.path
        setup_content_for(view, metadata)
        result
      ensure
        tempfile.close! if tempfile
      end

      private

        def create_tempfile_with(body)
          self.tempfile = Tempfile.new 'smartgen'
          tempfile.write body
          tempfile.rewind
        end

        def setup_content_for(view, metadata)
          metadata.content_for = Smartgen::ObjectHash.new unless metadata.has_key?(:content_for)
          metadata.content_for.merge!(process_content_for(view, metadata))
        end

        def process_content_for(view, metadata)
          view.instance_variable_get('@_content_for').inject({}) do |result, item|
            name, contents = item
            result[name] = engine.process_without_pre_processors(contents, metadata).html_safe
            result
          end
        end
    end
  end
end