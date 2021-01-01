document.addEventListener("turbolinks:load", function() {
  radio_buttons = document.querySelectorAll(".radio_button");
  form = document.querySelector("form")
  label = form.getElementsByTagName('label')
  input = form.getElementsByTagName('input')

  if(radio_buttons){
    radio_buttons.forEach(element =>
    element.addEventListener('click', () => {
      url = event.currentTarget.getAttribute("url")
      value = event.currentTarget.getAttribute("value")
      form.setAttribute("class", "new_" + value);
      form.setAttribute("id", "new_" + value);
      form.setAttribute("action", url);

      label[0].setAttribute("for", value + "_email");
      label[1].setAttribute("for", value + "_password");
      label[2].setAttribute("for", value + "_password_confirmation");

      input[1].setAttribute("name", value + "[email]");
      input[1].setAttribute("id", value + "_email");

      input[2].setAttribute("name", value + "[password]");
      input[2].setAttribute("id", value + "_password");

      input[3].setAttribute("name", value + "[password_confirmation]");
      input[3].setAttribute("id", value + "_password_confirmation");
    })
  )}
});
