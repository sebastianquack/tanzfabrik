class ChangeDefaultPageSection < ActiveRecord::Migration[6.0]
  def change
    Page.where(:section=>"stage").each do |p|
      p.section="buehne"
      p.save!
    end
  end
end
