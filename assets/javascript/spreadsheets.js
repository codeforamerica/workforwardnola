//'use strict';

function checkSpreadsheetUrl() {
  console.log($('[name="Spreadsheet URL"]').val());
  var
    spreadSheetKey,
    spreadSheetLink = event.target.value;

    if(!spreadSheetLink){
      console.log('link is empty');
      // this.setState({
        // linkStatus: 'empty',
        // createButtonDisabled: true
      // })
      return;
    }

    if(/https:\/\/docs\.google\.com\/spreadsheets\/d\/(.*)\//.test(spreadSheetLink)){
        console.log('link matches regex');
        spreadSheetKey = spreadSheetLink.match(/https:\/\/docs\.google\.com\/spreadsheets\/d\/(.*)\//)[1];

        // this.connectionSuccess = function(data){
        //   console.log(spreadSheetKey)
        //   this.setState({
        //     linkStatus: 'success',
        //     createButtonDisabled: false,
        //     spreadSheetLink: spreadSheetKey
        //   })
        // }.bind(this)

        // this.connectionError = function(err){
        //   console.error('no connection!');
        //   this.setState({
        //     linkStatus: 'bad-connection',
        //     createButtonDisabled: true
        //   })
        // }.bind(this)

        // $.get({
        //   url: 'https://spreadsheets.google.com/feeds/list/' + spreadSheetKey + '/1/public/full?alt=json',
        //   dataType: 'jsonp',
        //   success: this.connectionSuccess,
        //   error: this.connectionError
        // });

      } else {
        console.log('bad-format');
        // this.setState({
        //   linkStatus: 'bad-format',
        //   createButtonDisabled: true
        // })
      }

}
