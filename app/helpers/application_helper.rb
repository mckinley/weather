module ApplicationHelper
  def format_temperature(temp)
    "#{temp.to_f.round}° F"
  end
end
