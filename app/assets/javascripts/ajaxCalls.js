var filters = {};

function filterValues(){
  filters.timeOfDay = $('#time_of_day').val();
  console.log('filterEntries event firing');

  return(filters);
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
    debugger
  });
}
