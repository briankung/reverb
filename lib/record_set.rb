class RecordSet < Array
  def initialize(file)
    File.open(file).each_line do |l|
      self << Record.new(l)
    end
  end

  def list_by_gender
    (women + men).map(&:display)
  end

  def list(by: :birthdate)
    by == :gender ? list_by_gender : self.sort_by {|r| r[by]}.map(&:display)
  end

  private

  def women
    self.select {|r| r[:gender] == "Female" }.sort_by {|r| r[:last_name]}    
  end

  def men
    self.select {|r| r[:gender] == "Male" }.sort_by {|r| r[:last_name]}
  end
end