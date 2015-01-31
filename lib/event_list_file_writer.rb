class EventListFileWriter
  def write events, file_name
    CSV.open(file_name, "wb") do |csv|
      csv << ["Group name", "Event name", "Day of week", "Date", "Start time", "End time"]

      events.each do |event|
        start_time = time_with_offset(event['time'], event['utc_offset'])
        end_time = start_time + ms_to_seconds(event['duration'])

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

  private

  def time_with_offset time, offset
    Time.at(ms_to_seconds(time)).getlocal(ms_to_seconds(offset))
  end

  def ms_to_seconds ms
    ms / 1000
  end
end