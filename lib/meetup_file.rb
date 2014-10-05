require 'csv'

class MeetupFile

  def initialize
    @file_location = 'files/meetups.csv'
    @file_content = []
    CSV.foreach(@file_location, { :headers => true }) do |row|
      @file_content << row.to_hash unless group_id_populated? row
    end
  end

  def get_meetups_missing_ids
    result = []
    @file_content.each do |row|
      result << row unless group_id_populated? row
    end
    result
  end

  def update_file new_content

    @file_content.each do |old_row|
      new_content.each do |new_row|
        if group_match? old_row, new_row
          old_row['group_id'] = new_row['group_id']
        end
      end
    end
    save_file
  end

  private

  def group_id_populated? row
    !row['group_id'].nil?
  end

  def save_file
    CSV.open(@file_location, 'wb', {:force_quotes=>false, :headers => true}) do |csv|
      csv << @file_content.first.keys
      @file_content.each do |row|
        csv << row
      end
    end
  end

  def group_match? original_row, new_row
    original_row['group_urlname'] == new_row['group_urlname']
  end

end
