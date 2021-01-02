document.addEventListener("turbolinks:load", function() {
  radio_buttons = document.querySelectorAll(".radio_button");
  sign_in_page = document.querySelector("#sign_in_page")
  form = document.querySelector("form")
  input = form.getElementsByTagName('input')

  if(radio_buttons){
    radio_buttons.forEach(element =>
    element.addEventListener('click', () => {
      url = event.currentTarget.getAttribute("url")
      value = event.currentTarget.getAttribute("value")
      form.setAttribute("class", "new_" + value);
      form.setAttribute("id", "new_" + value);
      form.setAttribute("action", url);

      input[1].setAttribute("name", value + "[email]");
      input[1].setAttribute("id", value + "_email");

      input[2].setAttribute("name", value + "[password]");
      input[2].setAttribute("id", value + "_password");

      input[3].setAttribute("name", value + "[password_confirmation]");
      input[3].setAttribute("id", value + "_password_confirmation");
    })
  )}

  if(sign_in_page){
      label = form.getElementsByTagName('label')

      radio_buttons.forEach(element =>
      element.addEventListener('click', () => {
        url = event.currentTarget.getAttribute("url")
        value = event.currentTarget.getAttribute("value")
        form.setAttribute("class", "new_" + value);
        form.setAttribute("id", "new_" + value);
        form.setAttribute("action", url);

        input[1].setAttribute("name", value + "[email]");
        input[1].setAttribute("id", value + "_email");

        input[2].setAttribute("name", value + "[password]");
        input[2].setAttribute("id", value + "_password");

        input[3].setAttribute("name", value + "[remenber_me]");

        input[4].setAttribute("name", value + "[remenber_me]");
        input[4].setAttribute("id", value + "remenber_me");

        label[0].setAttribute("for", value + "_remember_me");
      })
    )}
});


