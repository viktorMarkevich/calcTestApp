$( document ).on('turbolinks:load', function() {
  clickOnAction();
  inputValidation();
});

function clickOnAction() {
  $('body').on('click', '.btn-secondary', function(e){
    e.preventDefault();
    var operator = $(e.target).data('operator');
    var argA = $('#calc_a').val();
    var argB = $('#calc_b').val();

    $.ajax({
      method: 'POST',
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: '/calcs.json',
      data: { calc: { operator: operator, a: argA, b: argB } },
      success: function (response) {
        $('#result').val(response.result);
      },
      error: function (errorResponse) {
        console.log('errorResponse: ', errorResponse);
      }
    });
  });
}

function inputValidation() {
  $('body').on('change keyup', '.calc-args', function(e){
    e.preventDefault();
    if (isInputValid(e.target) && isInputValid($(e.target).data('opposite'))) {
      $('.btn-disabled').removeClass('btn-disabled');
    } else {
      $('.btn-secondary').addClass('btn-disabled');
    }

    return false;
  });
}

function isInputValid(selector) {
  var inputVal = parseFloat($(selector).val());

  return (Number.isInteger(inputVal) && inputVal > 0 && inputVal < 100)
}