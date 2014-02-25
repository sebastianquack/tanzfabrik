ActiveAdmin.register Event do

  menu :priority => 1

  permit_params :id, :title, :description, :type_id, festivals_events_attributes: [:id, :festival_id, :event_id, :_destroy], persons_events_attributes: [:id, :festival_id, :person_id, :_destroy]

  index do 
    column "Festivals" do |event|
      event.festivals.map { |f| f.name }.join ', '
    end
    column :type
    column "People" do |event|
      event.people.map { |f| f.name }.join ', '
    end
    column :title
    actions
  end

  filter :title
  filter :type
  filter :festivals
  filter :people

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :type
    end

    f.inputs do
      f.has_many :festivals_events do |fe|
        if !fe.object.nil?
          # show the destroy checkbox only if it is an existing record
          fe.input :_destroy, :as => :boolean, :label => "Destroy?"
        end
        fe.input :festival
      end
    end

    f.inputs do
      f.has_many :persons_events do |pe|
        if !pe.object.nil?
          # show the destroy checkbox only if it is an existing record
          pe.input :_destroy, :as => :boolean, :label => "Destroy?"
        end
        pe.input :person
      end
    end

    f.actions
  end
  
  
end
