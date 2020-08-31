class StripDomainsFromLinks < ActiveRecord::Migration[6.0]
  include ModelHelpers
  def up
    ContentModule.all.map do |m| 
      if !m.link_href_en.to_s.empty?
        print m.link_href_en.to_s + " -> "
        m.link_href_en = ModelHelpers.strip_domain_from_link m.link_href_en.to_s
        puts m.link_href_en.to_s
      end

      if !m.link_href_de.to_s.empty?
        print m.link_href_de.to_s + " -> "
        m.link_href_de = ModelHelpers.strip_domain_from_link m.link_href_de.to_s
        puts m.link_href_de.to_s
      end

      m.save(validate: false)
    end
    Image.all.map do |i| 
      if !i.link_href_en.to_s.empty?
        print i.link_href_en.to_s + " -> "
        i.link_href_en = ModelHelpers.strip_domain_from_link i.link_href_en.to_s
        puts i.link_href_en.to_s
      end

      if !i.link_href_de.to_s.empty?
        print i.link_href_de.to_s + " -> "
        i.link_href_de = ModelHelpers.strip_domain_from_link i.link_href_de.to_s
        puts i.link_href_de.to_s
      end

      i.save(validate: false)
    end    
  end
end
