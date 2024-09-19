import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["navbar", "menu"]

  connect() {
    window.addEventListener("scroll", this.handleScroll.bind(this))
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll.bind(this))
  }

  handleScroll() {
    if (window.scrollY > 50) {
      this.navbarTarget.classList.add("scrolled")
      this.navbarTarget.classList.remove("transparent")
    } else {
      this.navbarTarget.classList.remove("scrolled")
      this.navbarTarget.classList.remove("transparent")
    }
  }

  toggleDropdown(event) {
    event.preventDefault();
    this.menuTarget.classList.toggle("show");
  }
}
