document.addEventListener("turbolinks:load", function() {
  // Assumes you've already included Stripe.js!
const stripe = Stripe('pk_test_51GyG8KCV96yeUuNKdPMaM13rDcWlkY8VbM0xiLjxWLur2wn3BNOhWelKknrKQU1I9SQBj52UzvyfZhnh9kYink2O00mBAoCPlS');

const myForm = document.querySelector('.my-form');

if(myForm){
myForm.addEventListener('submit', handleForm);
async function handleForm(event) {

  event.preventDefault();
  const accountResult = await stripe.createToken('account', {
    business_type: 'individual',
    external_account: document.querySelector('.inp-company-account').value,
    company: {
      name: document.querySelector('.inp-company-name').value,
      // tax_id: document.querySelector('.inp-company-siren').value,
      address: {
        line1: document.querySelector('.inp-company-street-address1').value,
        city: document.querySelector('.inp-company-city').value,
        state: document.querySelector('.inp-company-state').value,
        postal_code: document.querySelector('.inp-company-zip').value,
      },
    },
    individual: {
      first_name: document.querySelector('.inp-owners-first_name').value,
      last_name: document.querySelector('.inp-owners-last_name').value,
      dob: {
        day: document.querySelector('.inp-owners-day').value,
        month: document.querySelector('.inp-owners-month').value,
        year: document.querySelector('.inp-owners-year').value,
      },
    address: {
        line1: document.querySelector('.inp-owners-street-address1').value,
        city: document.querySelector('.inp-owners-city').value,
        state: document.querySelector('.inp-owners-state').value,
        postal_code: document.querySelector('.inp-owners-zip').value,
      },
    },
    individual :{

    },
    tos_shown_and_accepted: true,
  });

  // const personResult = await stripe.createToken('person', {
  //   person: {
  //     first_name: document.querySelector('.inp-person-first-name').value,
  //     last_name: document.querySelector('.inp-person-last-name').value,
  //     dob: {
  //       day: document.querySelector('.inp-owners-day').value,
  //       month: document.querySelector('.inp-owners-month').value,
  //       year: document.querySelector('.inp-owners-year').value,
  //     },
  //     address: {
  //       line1: document.querySelector('.inp-person-street-address1').value,
  //       city: document.querySelector('.inp-person-city').value,
  //       state: document.querySelector('.inp-person-state').value,
  //       postal_code: document.querySelector('.inp-person-zip').value,
  //     },
  //   },
  // });

  if (accountResult.token ) {
    document.querySelector('#token-account').value = accountResult.token.id;
    myForm.submit();
  }
};
};
});
