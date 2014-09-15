require 'net/http'
require 'json'


class MeetupAPI
  
  def initialize
    @base_uri = 'api.meetup.com'
    @groups_endpoint = '/groups'
    @api_key = ENV['MEETUP_API_KEY']
  end

  def get_meetup_id group_url_name
    @uri = URI::HTTP.build(:host => @base_uri, :path => @groups_endpoint, :query=> 'key=' + @api_key + '&group_urlname=' + group_url_name)
    get_url_response(@uri)['results'][0]['id']
  end

  private

  def get_url_response uri
    JSON.parse Net::HTTP.get uri
  end

end
