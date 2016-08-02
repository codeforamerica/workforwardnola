//= require_directory ./vendor
//

// custom JS can go in this file, or another, then you add another require line

function showCareerPrev(currIndex) {
  'use strict';

  var newIndex = parseInt(currIndex) - 1;
  if (newIndex > 0) {
    toggleCareer(currIndex, newIndex);
  }
}

function showCareerNext(currIndex, count) {
  'use strict';

  var newIndex = parseInt(currIndex) + 1;
  if (newIndex <= count) {
    toggleCareer(currIndex, newIndex);
  }
}

function toggleCareer(oldIndex, newIndex) {
  'use strict';

  $('[index='+oldIndex+']').hide();
  $('[index='+newIndex+']').show();
}

function showCareerList() {
  'use strict';

  $('.career').hide();
  $('#career-list').show();
}

function showCareer(index) {
  'use strict';

  $('#career-list').hide();
  $('[index='+index+']').show();
}
