document.addEventListener("turbolinks:load", function() {
  window.addEventListener('load', function(){
    let photos = document.querySelectorAll(".product_photo img").forEach((img) => {
      img.addEventListener("mouseover", (event) => {
        photo = event.currentTarget.getAttribute("src")
        document.querySelector("#zoom_photo img").setAttribute("src", photo);
      });
    });
  });
});
