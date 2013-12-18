var filters = {};

function filterValues(){
  console.log('filterEntries event firing');
  filters.timeOfDay = $('#time_of_day').val();
  filters.properNouns = $('#proper_nouns').val();

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
    App.subjectsUL.html('');
    App.avgMoodSpan.html(new_values_hash.avg_mood);
    App.avgWordCountSpan.html(new_values_hash.avg_word_count);
    App.sampleSizeSpan.html(new_values_hash.sample_size);
    App.tenseModeSpan.html(new_values_hash.tense_mode);
    _.each(new_values_hash.most_common_entities, function(e, i , l){
      marp = $('<li>').html(e);
      App.subjectsUL.append(marp);
    });

    // App.subjectsUL.append('<li>I like turtles</>');
  });
}
