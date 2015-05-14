class AddFirstLastNames < ActiveRecord::Migration
  
  def up
    add_column :people, :first_name, :string
    add_column :people, :last_name, :string
    rename_column :people, :name, :old_name
    Person.reset_column_information

    Person.find_each do |person|
      puts person.old_name
      if person.old_name.split.length == 1
        person.last_name = person.old_name
      elsif person.old_name.split.length > 1
        person.last_name = person.old_name.split.last
        person.first_name = person.old_name.split[0..-2].join(" ")  
      end
      person.save
      puts person.first_name
    end
  end

  def down
    remove_column :people, :first_name
    remove_column :people, :last_name
    rename_column :people, :old_name, :name
  end

end
