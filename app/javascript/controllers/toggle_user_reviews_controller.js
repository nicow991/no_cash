import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-user-reviews"
export default class extends Controller {
  static targets = [ "reviews" ]

  showreviews() {
    this.reviewsTarget.classList.toggle('d-none')
    this.reviewsTarget.scrollIntoView({behavior: "smooth"});
  }
}
