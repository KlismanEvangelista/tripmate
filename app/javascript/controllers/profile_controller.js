import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile"
export default class extends Controller {
  connect() {
    console.log('mostrar reviews');
    new Splide(".carousel-reviews", {
      type: 'loop',
      perPage: 2,
      perMove: 1,
      autoplay: true,
      pagination: false,
      gap: '1rem',
    }).mount();
  }
}
