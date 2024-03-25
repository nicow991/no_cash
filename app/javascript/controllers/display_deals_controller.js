import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-deals"
export default class extends Controller {

  static targets = [ "deal" ]

  showdeals() {
    this.dealTarget.classList.toggle('d-none')
    this.dealTarget.scrollIntoView({behavior: "smooth"});
  }
}
