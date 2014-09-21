
class MeetupFile

  def initialize
    @file = 'files/meetups.csv'
  end

  def get_meetup_names_without_ids

    result = []
    CSV.foreach(@file, { :headers => true }) do |row|
      result << row.to_a unless !row['group_id'].nil?
    end
    result
  end

end
