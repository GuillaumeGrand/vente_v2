document.addEventListener("turbolinks:load", function() {
const stripe = Stripe('pk_test_51GyG8KCV96yeUuNKdPMaM13rDcWlkY8VbM0xiLjxWLur2wn3BNOhWelKknrKQU1I9SQBj52UzvyfZhnh9kYink2O00mBAoCPlS');
console.log(1);
  checkoutButton = document.getElementById("checkout-buy");
console.log(2);

  checkoutButton.addEventListener('click', () => {
    console.log(3);
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
});
