## Adding Bootstrap to our Project

1. Run `bower init` to generate our initial bower.json file in our project directory.

2. Create a .bowerrc file in the root of your project and set the directory that our dependencies will be saved to:

  ```js
  {
    "directory":"vendor/assets/bower_components"
  }
  ```

3. Run `bower install bootstrap --save`

4. Now we need to will use sprockets to add to our project by adding the following to `/app/assets/stylesheets/application.css`

  ```css
  /*
   *= require bootstrap/dist/css/bootstrap
   *= require_tree .
   *= require_self
  */
  ```

5. Let's also add the bootstrap js to `/app/assets/javascripts/application.js`

  ```js
  //= require jquery
  //= require jquery_ujs
  //= require bootstrap/dist/js/bootstrap
  //= require turbolinks
  //= require_tree .
  ```

6. Restart your Rails server and you should now have Bootstrap added to our project.

7. Edit app/views/layouts/application.html.erb and put a `<div class = "container">` around the `<%= yield %>`
