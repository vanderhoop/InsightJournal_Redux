$( document ).ready(function() {
  console.log('app.js firing');
  $('#filter-btn').on("click", repopulateFields);
  // $('#filter-btn').on("click", filterAndRepopulate);
});
