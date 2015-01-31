class EventFinder
  def get_events_for_meetups(meetup_url_names, api)
    ids = meetup_url_names.map { |name| api.get_meetup_id name }

    api.get_upcoming_events(ids)
  end
end