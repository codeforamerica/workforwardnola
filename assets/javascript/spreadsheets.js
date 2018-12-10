'use strict';
let spreadSheetKey;
const messages = {
  success: {
    text: 'Successfully connected to Google Spreadsheet!',
    class: 'success'
  },
  empty: {
    text: 'Please paste in the spreadsheet link.',
    class: 'alert'
  },
  'bad-connection': {
    text: 'Hmm, something happened with the connection. Try again.',
    class: 'error'
  },
  'bad-format': {
    text: 'There\'s something wrong with the format of the link.',
    class: 'error'
  }
};

function checkSpreadsheetUrl () {
  let spreadSheetLink = $('[name="Spreadsheet URL"]').val();

  if (!spreadSheetLink) {
    console.warn('link is empty');
    setState({
      linkStatus: 'empty',
      updateButtonDisabled: true
    });
    return;
  }

  // https://docs.google.com/spreadsheets/d/1lMeZZ_vu-xIVKLgo7obKlF0X4iJ3oHkLKl8uIrPsSt8/pubhtml

  if (
    /https:\/\/docs\.google\.com\/spreadsheets\/d\/(.*)\//.test(spreadSheetLink)
  ) {
    console.info('link matches regex');
    spreadSheetKey = spreadSheetLink.match(
      /https:\/\/docs\.google\.com\/spreadsheets\/d\/(.*)\//
    )[1];

    this.connectionSuccess = function (data) {
      console.info(spreadSheetKey);
      setState({
        linkStatus: 'success',
        updateButtonDisabled: false,
        spreadSheetKey: spreadSheetKey
      });
    }.bind(this);

    this.connectionError = function (err) {
      console.warn('no connection!');
      setState({
        linkStatus: 'bad-connection',
        updateButtonDisabled: true
      });
    }.bind(this);

    $.get({
      url:
        'https://spreadsheets.google.com/feeds/list/' +
        spreadSheetKey +
        '/1/public/full?alt=json',
      dataType: 'jsonp',
      success: this.connectionSuccess,
      error: this.connectionError
    });
  } else {
    console.info('bad-format');
    setState({
      linkStatus: 'bad-format',
      updateButtonDisabled: true
    });
  }
}

function setState (
  state /* linkStatus, updateButtonDisabled, spreadSheetKey */
) {
  console.info(
    state.linkStatus +
      ', ' +
      state.updateButtonDisabled +
      ', ' +
      state.spreadSheetKey
  );

  $('#flash-results').hide();
  $('#flash-spreadsheet-link')
    .removeClass('flash-alert flash-success flash-error')
    .addClass('flash-' + messages[state.linkStatus].class);
  $('#flash-spreadsheet-link')
    .html(messages[state.linkStatus].text)
    .fadeIn();
  $('button').prop('disabled', state.updateButtonDisabled);
}

function updateFromSpreadsheet () {
  $('#flash-spreadsheet-link').hide();
  if (spreadSheetKey) {
    Tabletop.init({
      key: spreadSheetKey,
      callback: function (data, tabletop) {
        uploadData(data, tabletop);
      }
    });
  } else {
    setState({
      linkStatus: 'empty',
      updateButtonDisabled: true
    });
    console.warn('no spreadsheet key! everything is terrible.');
  }
}

function uploadData (data, tabletop) {
  let dataToSend = {};
  dataToSend.traits = data.traits.all();
  dataToSend.careers = data.careers.all();

  jQuery.post({
    url: '/careers/update',
    contentType: 'application/json; charset=utf-8',
    data: JSON.stringify(dataToSend),
    dataType: 'json',
    success: function (data) {
      console.info('omg ' + data.text);
      setResultsFlash(data.result, data.text);
    },
    error: function (jqXHR, textStatus) {
      setResultsFlash(
        'error',
        'A server error occurred. Please make sure your data is in the correct format and try again. If problems continue, contact an administrator.'
      );
    }
  });
}

function setResultsFlash (status, message) {
  $('#flash-results')
    .removeClass('flash-success flash-error')
    .addClass('flash-' + status);
  $('#flash-results')
    .html(message)
    .fadeIn();
}
