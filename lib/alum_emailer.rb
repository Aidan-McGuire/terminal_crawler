class AlumEmailer
  class << self
    def retrieve_emails(broken_links, profile_content)
      broken_profiles = Hash.new { |hash, key| hash[key] = [] }
      broken_links.each do |broken_link|
        profile_content.each do |email, links|
          if !links.grep(broken_link).empty?
            broken_profiles[email] << broken_link
          end
        end
      end
      broken_profiles
    end
  end
end