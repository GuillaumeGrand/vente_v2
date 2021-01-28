document.addEventListener("turbolinks:load", function() {
  const stripe = Stripe(gon.stripe_publishable_key);
  var createCheckoutSession = function(priceId) {
    return fetch("/checkout_sub", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        priceId: priceId
      })
    }).then(res => res.json());
  };
  let checkout_sub = document.getElementById("checkout_sub")
  let PriceId = "price_1HjNWcCV96yeUuNKWhjJCHbi"
  if(checkout_sub){
    checkout_sub.addEventListener("click", function() {
      createCheckoutSession(PriceId).then(function(data) {
        // Call Stripe.js method to redirect to the new Checkout page

        stripe
          .redirectToCheckout({
            sessionId: data.id
          })
          .then(handleResult);
      });
    });
  };
});
