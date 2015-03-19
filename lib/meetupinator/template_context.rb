module Meetupinator
  # Object passed to templates during formatting.
  class TemplateContext
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

    def sorted_events
      events.sort { |a, b| a[:start_time] <=> b[:start_time] }
    end

    def days_list(start_date, n)
      (0..(n - 1)).map { |d| add_days(start_date, d) }
    end

    def template_binding
      binding
    end

    private

    def add_days(date, n)
      date + n * DAY
    end
  end
end
