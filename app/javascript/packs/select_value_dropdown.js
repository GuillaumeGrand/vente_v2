window.addEventListener('DOMContentLoaded', function(){
  let select_quantity = document.querySelectorAll('.select_quantity')

  for(const [key, value] of Object.entries(select_quantity)){

    value.addEventListener('change', function() {
      quantity = String(this.value)
      id = this["id"]
      cart_id = id.charAt(0);

      fetch("update_cart", {
        method: "PATCH",
        body: JSON.stringify({ cart_id: cart_id,
                quantity: quantity }),
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': $( 'meta[name="csrf-token"]' ).attr( 'content' )
        }
      });
    });
  }
})
