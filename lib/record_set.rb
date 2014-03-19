require_relative 'record'

class RecordSet < Array
  def initialize(file)
    File.open(file).each_line do |l|
      self << Record.new(l)
    end
  end

  def list(by: :birthdate)
    if by == :gender then list_by_gender else self.sort_by {|r| r[by]} end
      .map(&:display)
  end

  private

  def list_by_gender
    (women + men)
  end

  def women
    self.select {|r| r[:gender] == "Female" }.sort_by {|r| r[:last_name]}    
  end

  def men
    self.select {|r| r[:gender] == "Male" }.sort_by {|r| r[:last_name]}
  end
end