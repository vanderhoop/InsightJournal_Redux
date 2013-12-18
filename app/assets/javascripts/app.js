$( document ).ready(function() {
  console.log('app.js firing');
  App = {};
  App.subjectsUL = $('#most-common-entities-ul');
  App.avgMoodSpan = $('#avg-mood');
  App.avgWordCountSpan = $('#avg-word-count');
  App.sampleSizeSpan = $('#sample-size');
  App.tenseModeSpan = $('#tense-mode');
  $('#filter-btn').on("click", repopulateFields);
});
