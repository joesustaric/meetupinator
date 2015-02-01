require 'net/http'
require 'json'

module MeetupThingy
  # class def
  class MeetupAPI
    attr_reader :api_key

    def initialize(api_key = nil)
      @base_uri = 'api.meetup.com'
      @groups_endpoint = '/2/groups'
      @events_endpoint = '/2/events'
      if key_valid?(api_key) || key_found_in_env?
        @api_key = retreive_key api_key
      else
        fail('no MEETUP_API_KEY provided')
      end
    end

    def get_meetup_id(group_url_name)
      query_string = 'key=' + @api_key + '&group_urlname=' + group_url_name
      uri = URI::HTTP.build(host: @base_uri, path: @groups_endpoint,
                            query: query_string)
      extract_meetup_id get_meetup_response(uri)
    end

    def get_upcoming_events(group_ids)
      query_string = 'sign=true&photo-host=public&status=upcoming&key=' +
                     @api_key + '&group_id=' + group_ids.join(',')
      uri = URI::HTTP.build(host: @base_uri, path: @events_endpoint,
                            query: query_string)
      response = get_meetup_response uri
      get_results response
    end

    private

    def get_meetup_response(uri)
      response = Net::HTTP.get_response uri

      if response.code != '200'
        msg = "Call to #{uri} failed: #{response.code} - #{response.message}"
        msg << '. ' + response.body if response.class.body_permitted?
        fail(msg)
      end

      JSON.parse response.body
    end

    def extract_meetup_id(response)
      get_results(response)[0]['id']
    end

    def get_results(response)
      response['results']
    end

    def retreive_key(api_key)
      return api_key if key_valid? api_key
      return ENV['MEETUP_API_KEY'] if key_found_in_env?
    end

    def key_valid?(api_key)
      !(api_key.nil? || api_key.empty?)
    end

    def key_found_in_env?
      !(ENV['MEETUP_API_KEY'].nil? || ENV['MEETUP_API_KEY'].empty?)
    end
  end
end
