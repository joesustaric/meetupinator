require 'csv'

class MeetupFile

  def initialize
    @file = 'files/meetups.csv'
  end

  def get_meetups_missing_ids
    result = []
    CSV.foreach(@file, { :headers => true }) do |row|
      result << row.to_hash unless group_id_populated? row
    end
    result
  end

  private

  def group_id_populated? row
    !row['group_id'].nil?
  end

end
