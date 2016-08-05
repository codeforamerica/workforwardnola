//'use strict';
var spreadSheetKey;

function checkSpreadsheetUrl() {
  console.log($('[name="Spreadsheet URL"]').val());
  var spreadSheetLink = event.target.value;

  if(!spreadSheetLink){
    console.log('link is empty');
    setState({
      linkStatus: 'empty',
      updateButtonDisabled: true
    });
    return;
  }

// https://docs.google.com/spreadsheets/d/1lMeZZ_vu-xIVKLgo7obKlF0X4iJ3oHkLKl8uIrPsSt8/pubhtml

  if(/https:\/\/docs\.google\.com\/spreadsheets\/d\/(.*)\//.test(spreadSheetLink)){
    console.log('link matches regex');
    spreadSheetKey = spreadSheetLink.match(/https:\/\/docs\.google\.com\/spreadsheets\/d\/(.*)\//)[1];

    this.connectionSuccess = function(data){
      console.log(spreadSheetKey);
      setState({
        linkStatus: 'success',
        updateButtonDisabled: false,
        spreadSheetKey: spreadSheetKey
      });
    }.bind(this);

    this.connectionError = function(err){
      console.error('no connection!');
      setState({
        linkStatus: 'bad-connection',
        updateButtonDisabled: true
      });
    }.bind(this);

    $.get({
      url: 'https://spreadsheets.google.com/feeds/list/' + spreadSheetKey + '/1/public/full?alt=json',
      dataType: 'jsonp',
      success: this.connectionSuccess,
      error: this.connectionError
    });

  } else {
    console.log('bad-format');
    setState({
      linkStatus: 'bad-format',
      updateButtonDisabled: true
    });
  }
}

// see https://github.com/janl/mustache.js for possible flash/alert-ing
function setState(state /* linkStatus, updateButtonDisabled, spreadSheetKey */) {
  console.log(state.linkStatus+', '+state.updateButtonDisabled+', '+state.spreadSheetKey);
  $('button').prop('disabled', state.updateButtonDisabled);
}

function updateFromSpreadsheet() {
  if(spreadSheetKey) {
    Tabletop.init({
      key: spreadSheetKey,
      callback: function (data, tabletop) {
        uploadData(data, tabletop);
        // update UI somehow (more flash messages probably)
      }
    });
  } else {
    console.log('no spreadsheet key! everything is terrible');
  }
}

function uploadData(data, tabletop) {
  // console.log(data.traits.all());
  $.postJSON('/careers/update', data.traits.all(), callback = function(data) {
    console.log('omg '+data.result);
  });
}
