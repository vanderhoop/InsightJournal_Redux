var filters = {};
// var avgMoodSpan = $('#avg-mood');
// var avgWordCountSpan = $('#avg-word-count');
// var sampleSizeSpan = $('#sample-size');
// var tenseModeSpan = $('#tense-mode');

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
  }).done(function(new_values_hash) {
    App.avgMoodSpan.html(new_values_hash.avg_mood);
    App.avgWordCountSpan.html(new_values_hash.avg_word_count);
    App.sampleSizeSpan.html(new_values_hash.sample_size);
    App.tenseModeSpan.html(new_values_hash.tense_mode);
  });
}
