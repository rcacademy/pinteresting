# Adding File Uploads

### Paperclip Gem
[Paperclip](https://github.com/thoughtbot/paperclip) is a gem that allows for easy file uploading in your Rails app.

The [documentation](https://github.com/thoughtbot/paperclip) for Paperclip can help you get started but the first step is to make sure we have ImageMagick installed. ImageMagick is a command line utility for working with and manipulating images.
##### PC

Install ImageMagick using the [Windows Binary here](http://www.imagemagick.org/script/binary-releases.php#windows).

You will also need a command line tool called "file" which is not available on Windows. You can install it by following the instructions here: [https://github.com/thoughtbot/paperclip#file](https://github.com/thoughtbot/paperclip#file).

##### Mac
Install [Homebrew](http://brew.sh/) if you don't already have it. You can check to see if you have it by entering `brew -v` in your terminal.

Once you have Homebrew, go ahead and install `imagemagick`.

`brew install imagemagick`

#### Test that ImageMagic is working
You can run `which convert` to see if ImageMagick has been installed properly.


### Using Paperclip

#### Add Paperclip to your Gemfile

```ruby
gem 'paperclip', '~> 4.3', '>= 4.3.6'
```

#### Adding an attachment to your model
For this project, let's assume I have a model called `Pin`. We're going to add an image attachment to our Pin model. You can name your field whatever you'd like, we're going to call ours `pin_image`.

```ruby
class Pin < ActiveRecord::Base
  has_attached_file :pin_image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :pin_image, content_type: /\Aimage\/.*\Z/
end
```

The styles we have defined for `pin_image` will allow us to access multiple sized versions of the image that is uploaded. Paperclip will use ImageMagick to automatically create those thumbnail sizes for us.

The 2nd line in our model helps us to verify that an image was uploaded. You can modify this to support other content types in the future. For example, you might want to support PDF uploads.

#### Generate a migration to add the attachment to your model

We can generate a paperclip specific migration by doing the following in our terminal.

`rails generate paperclip <model> <field_name>`

So for our example, I'll go ahead and run:

`rails generate paperclip pin pin_image`

Now perform `rake db:migrate` to run the migration and update our `Pin` model.

Now that we have added our field to the model and updated the database, we need to update our form for creating a pin.

#### Updating our view

Forms that upload files must have an attribute on them that indicates they support multipart form uploads. We can do this by adding `html: { multipart: true }` to our form_for element.

Next, we can add a `file_field` to our form and use the attribute we gave it.

```
<%= form_for @pin, url: pins_path, html: { multipart: true } do |form| %>
  <%= form.file_field :pin_image %>
<% end %>
```

If we try to create a new record with an image it will fail because we haven't added the `pin_image` attribute to our controller yet. Let's do that next.

#### Update our controller to permit the image attribute

In our app, we have defined `pin_params` to support a pin description but now we will add the `pin_image` attribute as well.

```ruby
def pin_params
  params.require(:pin).permit(:description, :pin_image)
end
```

We're almost there! If you go to your new_pin_path, you should be able to add a description and upload a file. Now we need to output the image to the screen.

#### Showing our images in our views

We can access the pin's pin_image after we've uploaded a file. Here are a few examples using the full image url, :medium and :thumb styled that we defined in our model.

The image_tag will render an `<img>` tag for us.

```
<%= image_tag(@pin.pin_image.url) %>

<%= image_tag(@pin.pin_image.url(:medium)) %>

<%= image_tag(@pin.pin_image.url(:thumb)) %>

```

If we want to make an image a link, we can do that with a combination or `link_to` and `image_tag`.

In this case, `@pin` is an instance variable that contains our pin.
```
<%= link_to image_tag(@pin.image.url(:medium)), @pin %>
```

This can also be written with the path defined.

```
<%= link_to image_tag(pin.image.url(:medium)), pin_path(@pin) %>
```

### Uploading files to Amazon S3

Now that we have images working on our local computers, we need to think about how we might support this on our server.

We are using Heroku for this class which does not function the same as other servers. If we deploy our code to Heroku, it should work but you will find that any of your uploaded files will eventually be deleted as Heroku does not support storing files.

To fix this, we're going to store our image using another 3rd party service called Amazon Web Services (AWS). AWS has a product called `S3` which is for storing files and content.

Paperclip supports uploading to S3 but we need to set it up manually.

#### Sign up for an Amazon AWS Account

Create a few account at [http://aws.amazon.com](http://aws.amazon.com). It might ask for a credit card but all users get added to the free tier to start with.

#### Setup S3
Find the S3 service under the Services tab. There should be an option to create a new bucket. Buckets are containers that we will use to store our files. You can use buckets to organize your uploads for 1 or more applications that you build so you don't have to create a new AWS account for each project you work on.

Create a new bucket and give it a name. Select `US Standard` for the region and click **create**.
