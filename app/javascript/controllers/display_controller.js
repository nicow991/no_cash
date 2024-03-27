import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "togglebtn", "info"]
  display() {
    console.log("displaying...")
      this.infoTarget.classList.toggle('d-none');
      this.infoTarget.scrollIntoView({ behavior: "smooth" });
      this.togglebtnTarget.classList.toggle('fa-circle-chevron-up');
      this.togglebtnTarget.classList.toggle('fa-circle-chevron-down');
  }
}
