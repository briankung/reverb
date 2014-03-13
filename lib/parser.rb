class Parser
  def self.parse(delimited_string = '')
    sanitized = self.sanitize(delimited_string) 
    {last_name: sanitized[0], first_name: sanitized[1], gender: sanitized[2], favorite_color: sanitized[3], birthdate: sanitized[4]}
  end

  def self.sanitize(string)
    string.split(',').map {|i| i.strip}
  end
end