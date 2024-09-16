import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="all-my-plans"
export default class extends Controller {
  connect() {
    document.querySelectorAll(".carousel-plan").forEach((plan)=> {
      new Splide(plan, {
        type: 'loop',
        perPage: 1,
        perMove: 1,
        autoplay: true,
        pagination: false,
        arrows: false,
      }).mount();
    })
  }
}
