class AddTicketLinkToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :ticket_link_url, :string
    add_column :events, :ticket_link_text_de, :string
    add_column :events, :ticket_link_text_en, :string
  end
end
