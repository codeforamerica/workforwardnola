//= require_directory ./vendor
//= require spreadsheets

// custom JS can go in this file, or another, then you add another require line

'use strict';

function showIFrame(id) {
  var iframe = $("#"+id);
  iframe.show();
}

function reverseTraitTrigger(trait, value) {
  var $traitInput = $("input[name='"+trait+"']");
  $traitInput.val(value);
  $traitInput.trigger('valueChange');
}

function checkTraitComponents(components) {
  var allMe = true;

  components.forEach(function(component) {
    var $componentInput = $("input[name='"+component+"']");
    var componentValue = $componentInput.val();
    var componentChecked = $componentInput.prop("checked") || $componentInput.attr("type") == 'hidden';
    if(!componentChecked || componentValue != "me") allMe = false;
  });

  return allMe;
}

function setElementFromComponents(element, components) {
  if(checkTraitComponents(components)) {
    $(element).val('me');
  } else {
    $(element).val('not-me');
  }
}

function bindTraitToComponents(element, componentString) {
  var components = JSON.parse(componentString);

  components.forEach(function(component) {
    var $componentInput = $("input[name='"+component+"']");

    if($componentInput.attr("type") == 'hidden') {
      $componentInput.on('valueChange', function() { setElementFromComponents(element, components); });
    } else {
      $componentInput.change(function() { setElementFromComponents(element, components); });
    }
  });
}

function enableSubmitWithRadioChanges() {
  var radioChanged = {};
  $('input:radio').each(function() {
    radioChanged[this.name] = false;
    $(this).change(function() {
      radioChanged[this.name] = true;
      var allChanged = true;
      for (var key in radioChanged) {
        if(radioChanged[key] == false) allChanged = false;
      }
      if(allChanged) $('button[type="submit"]').prop('disabled', false);
      if(allChanged) $("#assessment .error").hide();
    });
  });
}

// when the page loads, look for hidden compound traits & set up submit validation
$(document).ready(function() {
  $('[data-trait-components]').each(function() {
    bindTraitToComponents(this, $(this).attr('data-trait-components'));
  });

  enableSubmitWithRadioChanges();
});



// jQuery POST using JSON
$.postJSON = function(url, data, callback) {
    return jQuery.ajax({
        'type': 'POST',
        'url': url,
        'contentType': 'application/json; charset=utf-8',
        'data': JSON.stringify(data),
        'dataType': 'json',
        'success': callback
    });
};
