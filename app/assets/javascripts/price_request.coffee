$(document).ready ->
  $('#geo_address').geocomplete
    details: 'form'
    detailsAttribute: 'data-geo'
  return

$(document).ready ->
  $('#new_price_request').on("ajax:success", (e, data, status, xhr) ->
   $('.alert-section').remove()
   $('.rent_diff').html '<div class=\'rent_data\'> <div>Airbnb Rent: ' + data.average_airbnb_income + '</div> <div>Rent Diffrence: ' + data.rent_diffrence + '</div><div>'
  ).on "ajax:error", (e, xhr, status, error) ->
    error_labels = {avg_long_term_rental: 'Monthly Average Rental', address: 'Address'}
    error_obj = xhr.responseJSON['error']
    $('.alert-section').remove()
    $('.rent_diff').html ''
    Object.keys(error_obj).forEach (key) ->
      $('#new_price_request').prepend '<div class="alert-section"> <div class="alert alert-danger" role="alert"> <button type="button" class="close" data-dismiss="alert"> <span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button> <p>' + (error_labels[key] || '') + ' ' + error_obj[key] + '</p> </div></div>'
