//= require_directory ./vendor
//

// custom JS can go in this file, or another, then you add another require line

function showCareerPrev(currIndex) {
  'use strict';

  var newIndex = parseInt(currIndex) - 1;
  if (newIndex > 0) {
    showCareer(currIndex, newIndex);
  }
}

function showCareerNext(currIndex, count) {
  'use strict';

  var newIndex = parseInt(currIndex) + 1;
  if (newIndex <= count) {
    showCareer(currIndex, newIndex);
  }
}

function showCareer(oldIndex, newIndex) {
  'use strict';

  $('[index='+oldIndex+']').removeClass('show');
  $('[index='+newIndex+']').addClass('show');
}
