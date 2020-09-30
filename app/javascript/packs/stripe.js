document.addEventListener("turbolinks:load", function() {
  var elements = stripe.elements();
  var style = {
    base: {
      color: "#32325d",
    }
  };

  var card = elements.create("card", { style: style });
  card.mount("#card-element");

  card.on('change', ({error}) => {
    const displayError = document.getElementById('card-errors');
    if (error) {
      displayError.textContent = error.message;
    } else {
      displayError.textContent = '';
    }
  });
// 3.3 doc
  var form = document.getElementById('payment-form');

  form.addEventListener('submit', function(ev) {
    ev.preventDefault();
    stripe.confirmCardPayment(clientSecret, {
      payment_method: {
        card: card,
        billing_details: {
          name: 'Jenny Rosen'
        }
      }
    }).then(function(result) {
      if (result.error) {
        // Show error to your customer (e.g., insufficient funds)
        console.log(result.error.message);
      } else {
        // The payment has been processed!
        if (result.paymentIntent.status === 'succeeded') {
          // Show a success message to your customer
          // There's a risk of the customer closing the window before callback
          // execution. Set up a webhook or plugin to listen for the
          // payment_intent.succeeded event that handles any business critical
          // post-payment actions.
        }
      }
  });
});

  // subscription
function createCustomer() {
        let billingEmail = document.querySelector('#email').value;
        return fetch('/create-customer', {
          method: 'post',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            email: billingEmail,
          }),
        })
          .then((response) => {
            return response.json();
          })
          .then((result) => {
            // result.customer.id is used to map back to the customer object
            // result.setupIntent.client_secret is used to create the payment method
            return result;
          });
      }
​
      let signupForm = document.getElementById('signup-form');
​
      signupForm.addEventListener('submit', function (evt) {
        evt.preventDefault();
        // Create Stripe customer
        createCustomer().then((result) => {
          customer = result.customer;
        });
      });
});
