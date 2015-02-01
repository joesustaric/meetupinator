module MeetupThingy
  # class doco
  class InputFileReader
    def self.group_names(file_name)
      group_names = []
      File.open(file_name, 'rb') do |file|
        file.each_line { |line| group_names << line.strip }
      end
      group_names
    end
  end
end
