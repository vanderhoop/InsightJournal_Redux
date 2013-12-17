$( document ).ready(function() {
  console.log('app.js firing');
  App = {};
  App.avgMood = "Marp";
  App.avgMoodSpan = $('#avg-mood');
  App.avgWordCountSpan = $('#avg-word-count');
  App.sampleSizeSpan = $('#sample-size');
  App.tenseModeSpan = $('#tense-mode');
  $('#filter-btn').on("click", repopulateFields);
});
