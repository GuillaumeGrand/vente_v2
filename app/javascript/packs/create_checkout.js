document.addEventListener("turbolinks:load", function() {
  const stripe = Stripe(gon.stripe_publishable_key);
  checkoutButton = document.getElementById("checkout-buy");
  if(checkoutButton){
    checkoutButton.addEventListener('click', () => {
      store_id = checkoutButton.getAttribute("store_id");
      fetch('checkouts/create/' + store_id)
      .then(response => response.json())
      .then(result =>
      stripe.redirectToCheckout({


        sessionId: result["id"]
      }))
      // If `redirectToCheckout` fails due to a browser or network
      // error, display the localized error message to your customer
      // using `error.message`.
    });
  };
});
