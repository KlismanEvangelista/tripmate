import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flatpickr"
export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      enableTime: false,
      dateFormat: "Y-m-d",
    });
  }

  submit() {
    const form = document.querySelector("#date-filter-form");
    form.action = `?date=${this.element.value}`;
    form.submit();
  }
}
