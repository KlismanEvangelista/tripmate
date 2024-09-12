import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    new Splide("#carouselDepartaments", {
      type: 'loop',
      perPage: 3,
      perMove: 1,
      autoplay: true,
      pagination: false,
      arrows: true,
      gap: '1rem',
    }).mount();
  }
}
