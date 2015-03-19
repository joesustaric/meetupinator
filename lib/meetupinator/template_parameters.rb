module Meetupinator
  # Object passed to templates during formatting.
  class TemplateParameters
    attr_reader :events

    DAY = 60 * 60 * 24

    def initialize(events)
      @events = events
    end

    # FIXME: This will probably break for daylight savings
    def get_start_of_week(d)
      d -= DAY until d.monday?
      d
    end

    def template_binding
      binding
    end
  end
end
