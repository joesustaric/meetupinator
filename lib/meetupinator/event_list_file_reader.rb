require 'time'

module Meetupinator
  # Reads a list of events from a CSV file.
  class EventListFileReader
    def read(file_name)
      File.open file_name do |body|
        csv = CSV.new(body,
                      headers: true,
                      header_converters: :symbol,
                      converters: :all)
        csv.to_a.map(&:to_hash).each { |event| parse_dates(event) }
      end
    end

    private

    def parse_dates(event)
      event[:start_time] = parse_time_on_date(event[:date], event[:start_time])
      event[:end_time] = parse_time_on_date(event[:date], event[:end_time])
      event[:date] = Time.strptime(event[:date], '%d/%m/%Y')
    end

    def parse_time_on_date(date, time)
      time_format = '%d/%m/%Y %I:%M %p'
      time_with_date = date + ' ' + time
      Time.strptime(time_with_date, time_format)
    end
  end
end
