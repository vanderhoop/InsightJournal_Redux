$( document ).ready(function() {
  console.log('app.js firing');
  App = {};
  App.subjectsUL = $('#most-common-entities-ul');
  App.positiveEntitiesUL = $('#positive-entities');
  App.negativeEntitiesUL = $('#negative-entities');
  App.avgMoodSpan = $('#avg-mood');
  App.avgWordCountSpan = $('#avg-word-count');
  App.sampleSizeSpan = $('#sample-size');
  App.tenseModeSpan = $('#tense-mode');
  $('#filter-btn').on("click", repopulateFields);
});
