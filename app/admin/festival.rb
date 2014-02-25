ActiveAdmin.register Festival do

  menu :priority => 2
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :id, :name, :description, festivals_events_attributes: [:id, :festival_id, :event_id, :_destroy]

  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
  form do |f|
    f.inputs do
      f.input :name
      f.input :description
    end

    f.inputs do
      f.has_many :festivals_events do |ef|
        if !ef.object.nil?
          # show the destroy checkbox only if it is an existing record
          ef.input :_destroy, :as => :boolean, :label => "Destroy?"
        end
        ef.input :event
      end
    end
    f.actions
  end
  
  
end
