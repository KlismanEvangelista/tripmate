import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="all-my-plans"
export default class extends Controller {
  connect() {
    console.log('mostrar todos los planes');
    new Splide("#carouselMyPlans", {
      type: 'loop',
      perPage: 1,
      perMove: 1,
      autoplay: true,
      pagination: false,
      arrows: true,
      gap: '1rem',
    }).mount();
  }
}
