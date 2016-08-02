//= require_directory ./vendor
//

// custom JS can go in this file, or another, then you add another require line

'use strict';

function showPrevCareer(currIndex) {
  var newIndex = currIndex - 1;
  if (newIndex > 0) {
    toggleCareer(currIndex, newIndex);
  }
}

function showNextCareer(currIndex, count) {
  var newIndex = currIndex + 1;
  if (newIndex <= count) {
    toggleCareer(currIndex, newIndex);
  }
}

function toggleCareer(oldIndex, newIndex) {
  $('[index='+oldIndex+']').hide();
  $('[index='+newIndex+']').show();
}

function showCareerList() {
  $('.career').hide();
  $('#career-list').show();
}

function showCareer(index) {
  $('#career-list').hide();
  $('[index='+index+']').show();
}
