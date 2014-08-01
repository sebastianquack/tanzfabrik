class Registration < ActiveRecord::Base

  belongs_to :workshop_1, class_name: "Event", foreign_key: "workshop_id_1"
  belongs_to :workshop_2, class_name: "Event", foreign_key: "workshop_id_2"
  belongs_to :workshop_3, class_name: "Event", foreign_key: "workshop_id_3"
  belongs_to :workshop_4, class_name: "Event", foreign_key: "workshop_id_4"

end
