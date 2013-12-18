var filters = {};

function filterValues(){
  console.log('filterValues event firing');
  filters.timeOfDay = $('#time_of_day').val();
  return filters;
}

function repopulateFields(){
  var data = filterValues();
  var url = $('#filter-btn').attr('href');
  console.log("repopFields firing")
  $.ajax({
    type: "get",
    url: url,
    dataType: "json",
    data: data
  }).done(function(new_values_hash) {
    console.log("done function is firing");
    App.subjectsUL.html('');
    App.avgMoodSpan.html(new_values_hash.avg_mood);
    App.avgWordCountSpan.html(new_values_hash.avg_word_count);
    App.sampleSizeSpan.html(new_values_hash.sample_size);
    App.tenseModeSpan.html(new_values_hash.tense_mode);
    _.each(new_values_hash.most_common_entities, function(e, i , l){
      var newListItem = $('<li>').html(e.subject);
      var childUL = $('ul');
      $('<li>').html("Sentiment: " + e.most_common_sentiment).appendTo(childUL);
      // $('<li>').html("Appearances: " + e.count_total).appendTo(childUL);
      childUL.appendTo(newListItem);
      App.subjectsUL.append(newListItem);
    });

    // App.subjectsUL.append('<li>I like turtles</>');
  });
}
