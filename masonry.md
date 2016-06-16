### Adding Masonry to Your Project

To style our Pinterest clone, we're going to use a javascript library called [Masonry](masonry.desandro.com). This will allow us to create a grid with flowing elements vertically and horizontally. You can view the documentation and examples at [http://masonry.desandro.com/](http://masonry.desandro.com/).


### Install Masonry

Let's add Masonry to our project using Bower.

```bash
bower install masonry --save
```

Now we need to tell Rails to use Masonry. Unfortunately it will not work if you just do `require masonry` but instead include `masonry/dist/masonry.pkgd`. This will include the Masonry javascript in our template.

```js
//= require masonry/dist/masonry.pkgd
```

#### Using Masonry without Bootstrap

Once you have the above installed, we can setup our HTML and Javascript to tell our app what to render with Masonry.

```html
<div class="grid">
  <div class="grid-item">...</div>
  <div class="grid-item">...</div>
  <div class="grid-item">...</div>
</div>
```

We can control the width of our columns with CSS using the `.grid-item` selector. This width will also need to be defined in our javascript momentarily.

```css
.grid-item { width: 200px; }
```

Now finally, we need to add some jQuery that will tell our application to render our grid using Masonry. You do this like so:

:warning: Make sure you call this code **inside** of jQuery `document.ready` definition so that it runs once the DOM has been loaded.

```js
$('.grid').masonry({
  // options
  itemSelector: '.grid-item',
  columnWidth: 200
});
```

#### Using Masonry & Bootstrap

The above example is the simplest example you can create with Masonry. However, if you are using Bootstrap, you won't have any predefined column widths, but instead use responsive columns.

To setup Masonry with Bootstrap, we would change the following:

```html
<div class="grid row">
  <div class="grid-item col-md-4"></div>
  <div class="grid-item col-md-4">...</div>
  <div class="grid-item col-md-4">...</div>
</div>
```

```CSS
.grid-item {
    /* remove the css for width in .grid item */
    /* you might need to add some margin on the top or bottom of grid items */
}
```

We then need to change our javascript to target the `.grid-item` selector for both `itemSelector` and `columnWidth`. This allows Masonry to auto-detect the column width.

```js
$('.grid').masonry({
  itemSelector: '.grid-item',
  columnWidth: '.grid-item'
});

```


#### Using imagesLoaded to only render the view once the images have been loaded

If you use just Masonry to render our template, we might see some issues every now and then. Sometimes the masonry grid will be generated before the browser has fully rendered all the images on the page. This can cause some of the grid items to stack on top of one another. We can avoid this by using another library from the creator of Masonry, called [imagesLoaded](http://imagesloaded.desandro.com/).

```bash
bower install imagesloaded --save
```

```js
//= require imagesloaded/imagesloaded.pkgd
```

Now let's wrap our masonry javascript with the imagesLoaded call to run it only once our images have been loaded. We will still want to run this inside of `document.ready`.

```js
/* pins.js */
$(document).ready(function(){
  $('.grid').imagesLoaded(function() {
    $('.grid').masonry({
      itemSelector: '.grid-item',
      columnWidth: '.grid-item'
    });
  })
});
```
