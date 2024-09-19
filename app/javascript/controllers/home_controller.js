import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["department"]

  connect() {
    new Splide("#carouselDepartaments", {
      type: 'loop',
      perPage: 3,
      perMove: 1,
      autoplay: true,
      pagination: false,
      arrows: true,
      gap: '1rem',
      breakpoints: {
        640: {
            perPage: 1,
            perMove: 1,
          },
        768: {
            perPage: 2,
            perMove: 1,
          },
        1024: {
            perPage: 3,
            perMove: 1,
          }
      }
    }).mount();
  }

  filter() {
    console.log(this.departmentTarget)
    const value = this.departmentTarget.dataset.department
    window.location.href = `/plans?department=${value}`;
  }
}
