var filters = {};

// App.subjectsUL = $('#most-common-entities-ul');
// App.avgMoodSpan = $('#avg-mood');
// App.avgWordCountSpan = $('#avg-word-count');
// App.sampleSizeSpan = $('#sample-size');
// App.tenseModeSpan = $('#tense-mode');

function filterValues(){
  console.log('filterValues event firing');
  filters.timeOfDay = $('#time_of_day').val();
  // future filters
  // filters.season = $('#season').val();
  // filters.season = $('#season').val();
  return filters;
}

function repopulateFields(){
  var data = filterValues();
  // sets GET request URL from where I set it dynamically
  // in the DOM to account for different users
  var url = $('#filter-btn').attr('href');
  console.log("repopFields firing")
  $.ajax({
    type: "get",
    url: url,
    dataType: "json",
    data: data
  }).done(function(new_values_hash) {
    console.log("done function is firing");
    // empties Subjects List to prepare for rebuilding
    // App.subjectsUL.html('');
    App.avgMoodSpan.html(new_values_hash.avg_mood);
    App.avgWordCountSpan.html(new_values_hash.avg_word_count);
    App.sampleSizeSpan.html(new_values_hash.sample_size);
    App.tenseModeSpan.html(new_values_hash.tense_mode);
    $('#num-entries').html(new_values_hash.sample_size);
    debugger
    $("#humanity-sentiment").removeClass();
    $("#humanity-sentiment").addClass(new_values_hash.humanity_sentiment);
    $("#humanity-sentiment").html(new_values_hash.humanity_sentiment);
    $('#most-common-writing-time').remove();
    rebuildEntityList(App.positiveEntitiesUL, new_values_hash.positive_entities);
    rebuildEntityList(App.negativeEntitiesUL, new_values_hash.negative_entities);


    // _.each(new_values_hash.most_common_entities, function(e, i , l){
    //   console.log(e)
    //   var newListItem = $('<li>').html('<h4><span class=' + e.most_common_sentiment + '>'+ e.subject + '</h4>');
    //   var childUL = $('<ul>');
    //   $('<li>').html("Association: " + e.most_common_sentiment).appendTo(childUL);
    //   $('<li>').html("Appearances: " + e.count_total).appendTo(childUL);
    //   childUL.appendTo(newListItem);
    //   App.subjectsUL.append(newListItem);
    // }); // _.each



  }); // done
} // repopulateFields

function rebuildEntityList(elementToAppendTo, array_of_entities){
  // empties designated list of content for rebuild
  elementToAppendTo.html('');
  _.each(array_of_entities, function(e, i , l){
      console.log(e)
      var newListItem = $('<li>').html('<h4><span>' + e.subject + '</span></h4>');
      var childUL = $('<ul>');
      $('<li>').html("References: " + e.count_total).appendTo(childUL);
      childUL.appendTo(newListItem);
      elementToAppendTo.append(newListItem);
    }); // _.each
}
