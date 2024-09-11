import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="arrow"
export default class extends Controller {
  static targets = ["scrollButton"];

  connect() {
    this.scrollButtonTarget.addEventListener("click", this.scrollToTop);
  }

  disconnect() {
    this.scrollButtonTarget.removeEventListener("click", this.scrollToTop);
  }

  scrollToTop(event) {
    event.preventDefault();
    window.scrollTo({
      top: 0,
      behavior: 'smooth'
    });
  }
}
