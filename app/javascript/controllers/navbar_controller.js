import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["navbar"]

  connect() {
    window.addEventListener("scroll", this.handleScroll.bind(this))
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll.bind(this))
  }

  handleScroll() {
    if (window.scrollY > 50) {
      this.navbarTarget.classList.add("scrolled")
    } else {
      this.navbarTarget.classList.remove("scrolled")
    }
  }
}
