class RecordSet < Array
  def initialize(file)
    File.open(file).each_line do |l|
      self << Record.new(l)
    end
  end

  def list_by_birthdate
    self.sort_by {|r| r[:birthdate]}.map(&:display)
  end

  def list_by_gender
    (women + men).map(&:display)
  end

  def list_by_last_name
    self.sort_by {|r| r[:last_name]}.map(&:display)
  end

  private

  def women
    self.select {|r| r[:gender] == "Female" }.sort_by {|r| r[:last_name]}    
  end

  def men
    self.select {|r| r[:gender] == "Male" }.sort_by {|r| r[:last_name]}
  end
end