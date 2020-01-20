class ShelvesController < ApplicationController
    def create_new_shelf(active_user)
        done = false
        until done == true
            new_shelf_name = ask_user_for_new_shelf
            shelf = Shelf.all.find {|shelf| shelf.name == new_shelf_name && shelf.user.name == active_user.name}
            if shelf
                done = shelf_already_exists(active_user, shelf)
            else
                puts "\nPlease enter a description for your new bookshelf '#{new_shelf_name}' or press 'enter' to skip."
                new_shelf_description = STDIN.gets.chomp
                my_new_shelf = Shelf.create(name: new_shelf_name, description: new_shelf_description, user_id: active_user.id)
                active_user.shelves << my_new_shelf
                active_user.save
                puts "\n\nYour new shelf #{my_new_shelf.name} has been successfully created!"
                done = true
                STDIN.gets.chomp
                puts `clear`
            end
        end
    end
    
    def delete_shelf(shelf, active_user)
        puts "Are you sure you want to delete your shelf: #{shelf.name}? (y/n)"
        action = STDIN.gets.chomp
        if action == 'y'
            active_user.shelves.delete(shelf)
            Shelf.all.delete(shelf)
        end
        
    end
    
    def ask_user_for_new_shelf
        puts `clear`
        puts "What would you like to name your new shelf?"
        new_shelf_name = STDIN.gets.chomp
    end
    
    #helper method if the user tries to create a shelf that is already in the database
    def shelf_already_exists(active_user, shelf)
        text = <<-TEXT
    \nOops! That shelf already exists!\n
    What would you like to do?\n
        1. Modify shelf
        2. Try a new shelf name\n
            TEXT
        puts text
        action = 0
        until action == 1 || action == 2
            action = STDIN.gets.chomp.to_i
            if action == 1
                modification = modify_shelf_menu # print options for how user can interact with the shelf
                modify_shelf(modification, active_user)
                return done = true
            end
        end
    end

    def shelf_options(active_user) #main thing we run under main menu option 4
        puts "\nYour shelves:"
        print_shelf_list(active_user) # print list of all user's shelves
        to_menu = false
        until to_menu == true
            action = modify_shelf_menu #returns a user action
            to_menu = modify_shelf(action, active_user)
        end
    end
    
    def modify_shelf_menu #returns a menu action
        menu = <<-TXT 
        \n\nWhat would you like to do?\n
        1. View Shelf Contents 
        2. Remove Book 
        3. Add Book 
        4. Rename Shelf 
        5. Edit Shelf Description
        6. Return \n
        TXT
        #a stretch goal would be to add an option here to move a book to a different shelf
        puts menu
        action = STDIN.gets.chomp.to_i
    end
    
    def modify_shelf(action, active_user) #takes in a shelf instance
        case action #need to loop around this if statement to some extent
        when 1  #view shelf contents
            shelf_choice = choose_shelf(active_user) # get user to select a shelf to interact with
            puts `clear`
            shelf_choice.view_shelf_contents 
            to_menu = false
        when 2 #remove a book from a shelf
            puts `clear`
            shelf_choice = choose_shelf(active_user) # get user to select a shelf to interact with
            remove_book(shelf_choice, active_user)
            STDIN.gets.chomp
            puts `clear`
            # (stretch to remove from all shelves at once)
        when 3 #add a book to a shelf 
            puts `clear`
            shelf_choice = choose_shelf(active_user) # get user to select a shelf to interact with
            add_book(shelf_choice) #either adds a book to a shelf or does nothing and returns us to the modify contents menu
            STDIN.gets.chomp
            puts `clear`
        when 4 #rename shelf
            puts `clear`
            shelf_choice = choose_shelf(active_user)
            rename_shelf(shelf_choice) # get user to select a shelf to interact with
            STDIN.gets.chomp
            puts `clear`
            #rename shelf(shelf_choice)
        when 5 #edit shelf description
            puts `clear`
            shelf_choice = choose_shelf(active_user)
            edit_shelf_description(shelf_choice)
            STDIN.gets.chomp
            puts `clear`
        when 6 #return to main menu
            puts `clear`
            to_menu = true
        else
            unknown_command
        end
        
    end
    
    def index
        
    end
    
    def new
    
    end
    
    def create
    
    end
    
    def edit
    
    end
    
    def update
    
    end
    
    def show
    
    end
    
    def destroy
    
    end
end
