module Meetupinator
  # Creates a nicely-formatted version of a list of events.
  class Formatter
    def format(events, template_file, output_file)
      template_engine = ERB.new(File.read(template_file))
      parameters = TemplateParameters.new(events)
      output = template_engine.result(parameters.template_binding)

      FileUtils.mkdir_p(File.dirname(output_file))
      File.write(output_file, output)
    end

    # Object passed to templates.
    class TemplateParameters
      attr_reader :events

      def initialize(events)
        @events = events
      end

      def template_binding
        binding
      end
    end
  end
end
