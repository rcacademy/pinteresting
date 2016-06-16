var ready = function(){
  $('.grid').imagesLoaded(function() {
    $('.grid').masonry({
      itemSelector: '.grid-item',
      columnWidth: '.grid-item'
    });
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);
