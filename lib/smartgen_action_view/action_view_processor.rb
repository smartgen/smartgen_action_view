module Smartgen
  module Engine
    module ActionViewProcessor
      attr_accessor :tempfile

      module DefaultHelpers
        attr_accessor :metadata
      end

      def process_template(body, metadata)
        create_tempfile_with(body)

        view = ::ActionView::Base.new File.dirname(tempfile.path)
        view.extend(DefaultHelpers)
        view.metadata = metadata

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
          result[name] = process_by_engine(contents, metadata)
          result
        end
      end
    end
  end
end