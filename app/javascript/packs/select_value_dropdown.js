window.addEventListener('DOMContentLoaded', function(){
  let select_quantity = document.querySelectorAll('.select_quantity')

  for(const [key, value] of Object.entries(select_quantity)){

    value.addEventListener('change', function() {
      quantity = String(this.value)

      a = this.closest("a").getAttribute("data-params") + quantity
      this.closest("a").setAttribute("data-params", a)

    });
  }
})
