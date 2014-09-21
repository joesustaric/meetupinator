require 'net/http'
require 'json'


class MeetupAPI

  def initialize
    @base_uri = 'api.meetup.com'
    @groups_endpoint = '/groups'
    @api_key = ENV['MEETUP_API_KEY']
  end

  def get_meetup_id group_url_name
    uri = URI::HTTP.build(:host => @base_uri, :path => @groups_endpoint, :query=> 'key=' + @api_key + '&group_urlname=' + group_url_name)
    extract_meetup_id get_meetup_response(uri)
  end

  private

  def get_meetup_response uri
    JSON.parse Net::HTTP.get uri
  end

  def extract_meetup_id group_response
    group_response['results'][0]['id']
  end

end
