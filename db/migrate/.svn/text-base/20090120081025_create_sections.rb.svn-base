class CreateSections < ActiveRecord::Migration
  def self.up
    
    # Create sections table
    create_table :sections do |t|
      t.string :name, :uri
      t.text :description
      t.timestamps
    end
    
    # We want to keep the old section name but we don't want the section attribute interferring with 
    # our app. - so we rename it!
    rename_column :posts, :section, :old_section

    # Time to add in the sections...
    create_table :posts_sections, :id => false do |t|
      t.integer :post_id, :section_id
    end

    # Here is the sample data for our sections
    sections = 
     [{ :name => "Featured Voices", 
        :description => "Featured Voices speak to ideas that connect us. Each serves as the centerpiece for an issue of P&P. "},
      { :name => "Perspectives",
        :description => "Perspective articles critique, extend or illustrate the P&P featured essays. "},
      { :name => "Our Compass",
        :description => "Our Compass points to leading websites and articles on each P&P topic. "},
      { :name => "On The Wire",
        :description => "On the Wire articles relay ideas and voices from around the Net. "}
      ]
      
    # Create sections using sample data
     sections.each do |section|
       Section.create(section)
     end
     
     # Add section found in old section to the post sections and redo the published status
     Post.find(:all).each do |post|
       if post.status == "Published"
         post.published = true
       end
       section = Section.find_by_name(post.old_section)
       post.sections << section
       post.save
     end
     
  end

  def self.down
    drop_table :sections
    rename_column :posts, :old_section, :section
    Post.find(:all).each do |post|
      post.section = post.section.name
    end
    drop_table :posts_sections
  end
end
