import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {

  static targets = [ "form" ]

  showoffer() {
    this.formTarget.classList.toggle('d-none')
  }
}
