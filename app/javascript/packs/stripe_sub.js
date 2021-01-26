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
console.log(checkout_sub)
  let PriceId = "price_1HjNWcCV96yeUuNKWhjJCHbi"
    console.log(2)
  if(checkout_sub){
      console.log(3)
    checkout_sub.addEventListener("click", function(evt) {
      console.log(4)
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
