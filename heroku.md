# Deploying to Heroku

#### Create a Heroku account

This will be where we host all of our applications for this class. It is a great service for hosting applications.

* [Go to Heroku](http://heroku.com)


#### Install the Heroku Toolbelt
* [Windows Toolbelt](https://toolbelt.heroku.com/windows)
* [Mac Toolbelt](https://toolbelt.heroku.com/osx)

Follow the instructions for your respective operating system in order to add the `heroku` command to our terminal and setup our SSH keys in Heroku.

#### Create our Heroku Application
Make sure your app is being tracked with git.

```bash
git status
```

If you get an error indicating that there is not an initialized git repository, you can add it by running:

```bash
git init
```
Now you can create a Heroku app from within the root of your project with the following:

```bash
heroku create
```

You should see a url and some CLI output if this is successful.

```
Creating app... done, ⬢ ancient-ridge-92332
https://ancient-ridge-92332.herokuapp.com/ | https://git.heroku.com/ancient-ridge-92332.git

```


#### Edit your Gemfile
To run our app on Heroku, we need to make some minor changes to our Gemfile.

Find the line where we define the use of sqlite.

```ruby
gem 'sqlite3'
```

Remove that line and replace it with the following:
```ruby
group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
```

This is going to tell our Rails app to use `sqlite3` when we are developing locally but to use `pg` or Postgresql when we are in production. Our Heroku server will be our production environment.

Typically we would also want to setup some configuration to tell our Rails app how and where to connect to Postgres but for now, we will just go ahead and let it detect the default values. In other projects we will end up using Postgresql for both our local and production environments.


##### Ruby - what's your version?
Let's also define our Ruby version in our Gemfile. This will tell Heroku which version of Ruby to use.

Add the version of Ruby you are using to the end of your Gemfile:

```ruby
ruby "2.2.0"
```

Every time the Gemfile changes you need to apply those changes with bundler.

```bash
bundle install --without production
```

#### Commit your Gemfile changes
Now that we've changed our `Gemfile` and generated a new updated `Gemfile.lock` file, we need to commit them.

```bash
git add .
git commit -m "Changed Gemfile for Heroku"
```

### Deploying to Heroku
If everything is committed properly we should be able to deploy our app to Heroku.

When you ran `heroku create` earlier, it added a new git remote to our project. You can view this by using the verbose git remote command:
```bash
git remote -v
```

If you've added an origin (usually pointing to Github), you will see the `origin` remote as well as a `heroku` remote that was added by the Heroku Toolbelt.

We can now do a git push to Heroku to deploy our app.

```bash
git push heroku master
```

#### Run your database migrations

Once your app is on Heroku, we will still need to tell it create our tables.

We will do this just like we do locally with `rake db:migrate` but we need to tell Heroku to run it.

```bash
heroku run rake db:migrate
```

This will create our tables using the

#### Open your app
The Heroku Toolbelt gives us a shortcut to get to our application:

```bash
heroku open
```

This will launch your browser and load your application.

## Official Docs for Rails 4.x on Heroku
You can read more in depth on using Rails 4.x on heroku here: [https://devcenter.heroku.com/articles/getting-started-with-rails4](https://devcenter.heroku.com/articles/getting-started-with-rails4)
