class EventListFileWriter
  def write events, file_name
    CSV.open(file_name, "wb") do |csv|
      csv << ["Group name", "Event name", "Day of week", "Date", "Start time", "End time"]

      events.each do |event|
        # FIXME We ignore the 'utc_offset' attribute and instead just get the time in the local time zone
        # ('time' is given in milliseconds since the epoch in UTC)
        start_time = Time.at(event['time'] / 1000)
        end_time = start_time + event['duration'] / 1000

        csv << [
            event['group']['name'],
            event['name'],
            start_time.strftime('%A'),
            start_time.strftime('%e/%m/%Y'),
            start_time.strftime('%-l:%M %p'),
            end_time.strftime('%-l:%M %p')
        ]
      end
    end
  end
end