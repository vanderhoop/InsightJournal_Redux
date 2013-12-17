var hashToPass = {};

function filterValues(){
  hashToPass.timeOfDay = $('#time_of_day').val();
  console.log('filterEntries event firing');

  return(hashToPass.timeOfDay);
}

function repopulateFields(){
  var data = filterValues();
  var url = $('#filter-btn').attr('href');
  $.ajax({
    type: "get",
    url: url,
    dataType: "json",
    data: data
  }).done(function(msg) {
    console.log(msg);
  })
}
