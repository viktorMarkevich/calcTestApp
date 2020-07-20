$( document ).on('turbolinks:load', function() {

  clickOnAction();
});

function clickOnAction() {
  $('body').on('click', '.btn-secondary', function(e){
    e.preventDefault();
    console.log($(e.target).data('action'));

  });
}