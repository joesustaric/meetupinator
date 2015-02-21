require 'csv'

module Meetupinator
  # class def
  class EventListFileWriter
    def write(events, file_name)
      CSV.open(file_name, 'wb') do |csv|
        csv << ['Group name', 'Event name', 'Day of week', 'Date',
                'Start time', 'End time', 'Event URL']
        events.each do |event|
          csv << extract_row(event)
        end
      end
    end

    private

    def extract_row(event)
      start_time, end_time = extract_times event
      [
        event['group']['name'], event['name'], start_time.strftime('%A'),
        start_time.strftime('%-e/%m/%Y'), start_time.strftime('%-l:%M %p'),
        end_time.strftime('%-l:%M %p'), event['event_url']
      ]
    end

    def extract_times(event)
      start_time = time_with_offset(event['time'], event['utc_offset'])
      # According to http://www.meetup.com/meetup_api/docs/2/events/,
      # if no duration is specified, we can assume 3 hours.
      # TODO: We should probably display a warning when this happens.
      duration = event['duration'] || three_hours
      end_time = start_time + ms_to_seconds(duration)

      [start_time, end_time]
    end

    def time_with_offset(time, offset)
      Time.at(ms_to_seconds(time)).getlocal(ms_to_seconds(offset))
    end

    def ms_to_seconds(ms)
      ms / 1000
    end

    def three_hours
      3 * 60 * 60 * 1000
    end
  end
end
