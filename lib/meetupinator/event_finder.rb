module Meetupinator
  # class def
  class EventFinder
    def extract_events(group_url_names, api, weeks)
      ids = group_url_names.map { |name| api.get_meetup_id name }

      api.get_upcoming_events(ids, weeks)
    end
  end
end
