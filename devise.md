## Creating a user registration system

1. Add the Devise gem to your Gemfile and run `bundle install`.

2. Run `rails generate devise:install` to start the install script.

3. Follow the CLI instructions after Devise has been installed.

4. Setup your devise user model: `rails generate devise user`.

5. Run `rake db:migrate` to create the user model.

6. Run `rake routes` to see our newly generated user, password and user_session routes.

7. You should now be able to start your server and visit the route for creating a new user: `/users/sign_up`.

8. You will now have various views available to you in `views/devise` that pertain to sign up, login and forgot password functionality.

9. You will now want to associate your `pin` model with the `user` model.

  `rails generate migration add_user_id_to_pins user_id:integer:index`

  Finally, let's define our association in our `pin` and `user` models.

  **app/models/pin.rb**
  ```ruby
  class Pin < ActiveRecord::Base
    belongs_to :user
  end
  ```

  **app/models/user.rb**
  ```ruby
  class User < ActiveRecord::Base
    has_many :pins
  end
  ```

10. Now we can add some logic to our controllers to enforce that our user is logged in and is the correct user to perform certain actions.

  **app/controllers/pins_controller.rb**
  ```ruby
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  ```

11. Update our create method in our `PinsController` to create a pin associated with the logged in user.

  **app/controllers/pins_controller.rb**
  ```ruby
  def new
      @pin = current_user.pins.build
  end

  def create
      @pin = current_user.pins.build(pin_params)
      if @pin.save
        redirect_to @pin, notice: 'Pin was created successfully!'
      else
        render 'new'
      end
  end
  ```
12. If we try to create new pins, we will get an error because we have yet to define our `correct_user` before_action.

  **app/controllers/pins_controller.rb**
  ```ruby
  private
  def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
  end  
  ```
