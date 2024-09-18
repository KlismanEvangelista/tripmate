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
    }).mount();
  }

  filter() {
    console.log(this.departmentTarget)
    const value = this.departmentTarget.dataset.department
    window.location.href = `/plans?department=${value}`;
  }
}
