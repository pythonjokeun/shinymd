function to_title_case(str) {
  return str.replace(
    /\w\S*/g,
    function(txt) {
      return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
    }
  );
}

// ON FIRST INIT
$(document).on('shiny:connected', function() {
  // SET INITIAL ACTIVE SIDEBAR TAB
  $('.sidebar').find('li').first().addClass('active');

  // LOAD INITIAL ACTIVE BODY CONTENT
  $('.content > .tab-content > .tab-pane').first().addClass('active show');

  // SET NAVBAR TEXT TO MATCH INITIAL ACTIVE SIDEBAR
  $('.navbar-brand').text(to_title_case($('.nav-item').first().find('p').text()));

  // ON SIDEBAR TAB CLICKED
  $('.nav-item').click(function() {
    $(this).addClass('active');
    $(this).siblings().removeClass('active');

    var active_tab_name = $(this).find('p').text();
    $('.navbar-brand').text(to_title_case(active_tab_name));
  });
});

// MATCH ACTIVE SIDEBAR COLOR + SHADOW WITH FOCUSED NAVBAR DROPDOWN ITEM COLOR + SHADOW
$(document).on('shiny:conditional', function() {
  if ($('.sidebar-wrapper > ul').length) {
    $('.dropdown-item').mouseover(function() {
      var sidebar_active_data_color = $('.sidebar').attr('data-color');

      // COLOR
      var sidebar_active_color_css = $(
        '.sidebar[data-color="' + sidebar_active_data_color + '"] li.active > a'
      ).css('background-color');

      $(this).siblings().css({
        'background-color': '',
        'color': 'black'
      });

      $(this).css({
        'background-color': sidebar_active_color_css,
        'color': 'white'
      });

      // SHADOW
      var sidebar_active_shadow_css = $(
        '.sidebar[data-color="' + sidebar_active_data_color + '"] li.active > a'
      ).css('box-shadow');

      $(this).siblings().css({'box-shadow': ''});
      $(this).css({'box-shadow': sidebar_active_shadow_css});
    });

    $('.dropdown-item').mouseleave(function() {
      $(this).css({
        'background-color': '',
        'color': 'black',
        'box-shadow': ''
      });
    });
  } else {
    $('.dropdown-item').mouseover(function() {
      $(this).siblings().css({'color': 'black'});
      $(this).css({'color': 'white'});
    });

    $('.dropdown-item').mouseleave(function() {
      $(this).css({'color': 'black'});
    });
  }
});
