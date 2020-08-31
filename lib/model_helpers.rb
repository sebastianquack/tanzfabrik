module ModelHelpers
  def ModelHelpers.strip_domain_from_link str
    Rails.configuration.domains_to_remove_from_links.each do |d|
      str = str.gsub(/^ *https{0,1}:\/\/[\w\.]*#{d}\//, "/")
    end
    str
  end
end