require 'net/http'
require 'json'


class MeetupAPI

  def initialize

  end

  def get_meetup_id(group_url_name)
    url = 'http://api.meetup.com/groups?radius=25.0&order=ctime&group_urlname='+ group_url_name + '&offset=0&photo-host=public&format=json&page=20&fields=&key=e176f7017712c636d307852216d828'
    response = JSON.parse Net::HTTP.get URI.parse url
    response['results'][0]['id']
  end

end
