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

  def update_file new_content

    result = []
    CSV.foreach(@file,{ :headers => true}) do |row|
      result << row.to_hash
    end
    result

    result.each do |old_row|
      new_content.each do |new_row|
        if old_row['group_urlname'] == new_row['group_urlname']
          old_row['group_id'] = new_row['group_id']
        end
      end
    end

    CSV.open(@file, 'wb', {:force_quotes=>false, :headers => true}) do |csv|
      csv << result.first.keys
      result.each do |row|
        csv << row
      end
    end
    
  end

  private

  def group_id_populated? row
    !row['group_id'].nil?
  end

end
