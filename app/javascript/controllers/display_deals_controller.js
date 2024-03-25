import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "completeddeal", "canceleddeal",
   "accepteddeal", "sentoffer", "receivedoffer", 'chevroncanceled',
   'chevronaccepted', 'chevroncompleted',
   'chevronsent', 'chevronreceived']

  completed() {
    const completedDealTarget = this.targets.find("completeddeal");
    if (completedDealTarget) {
      completedDealTarget.classList.toggle('d-none');
      completedDealTarget.scrollIntoView({ behavior: "smooth" });
      this.chevroncompletedTarget.classList.toggle('fa-circle-chevron-up');
      this.chevroncompletedTarget.classList.toggle('fa-circle-chevron-down');
    }
  }

  canceled() {
    const canceledDealTarget = this.targets.find("canceleddeal");
    if (canceledDealTarget) {
      canceledDealTarget.classList.toggle('d-none');
      canceledDealTarget.scrollIntoView({ behavior: "smooth" });
      this.chevroncanceledTarget.classList.toggle('fa-circle-chevron-up');
      this.chevroncanceledTarget.classList.toggle('fa-circle-chevron-down');
    }
  }

  accepted() {
    const acceptedDealTarget = this.targets.find("accepteddeal");
    if (acceptedDealTarget) {
      acceptedDealTarget.classList.toggle('d-none');
      acceptedDealTarget.scrollIntoView({ behavior: "smooth" });
      this.chevronacceptedTarget.classList.toggle('fa-circle-chevron-up');
      this.chevronacceptedTarget.classList.toggle('fa-circle-chevron-down');
    }
  }

  sent() {
    const sentOfferTarget = this.targets.find("sentoffer");
    if (sentOfferTarget) {
      sentOfferTarget.classList.toggle('d-none');
      sentOfferTarget.scrollIntoView({ behavior: "smooth" });
      this.chevronsentTarget.classList.toggle('fa-circle-chevron-up');
      this.chevronsentTarget.classList.toggle('fa-circle-chevron-down');
    }
  }

  received() {
    const receivedOfferTarget = this.targets.find("receivedoffer");
    if (receivedOfferTarget) {
      receivedOfferTarget.classList.toggle('d-none');
      receivedOfferTarget.scrollIntoView({ behavior: "smooth" });
      this.chevronreceivedTarget.classList.toggle('fa-circle-chevron-up');
      this.chevronreceivedTarget.classList.toggle('fa-circle-chevron-down');
    }
  }
}
