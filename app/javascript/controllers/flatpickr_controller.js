import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = ["form", "date"]

  connect() {
    const initialDate = this.dateTarget.value || null;

    flatpickr(this.dateTarget, {
      enableTime: false,
      dateFormat: "d-m-Y",
      minDate: "today",
      defaultDate: initialDate,
      locale: "es",
      allowInput: true,
    });
  }

  search(event) {
    event.preventDefault();
    const selectedDate = this.dateTarget.value;

    if (selectedDate) {
      window.location.href = `?date=${selectedDate}`;
    } else {
      window.location.href = `?`;
    }
  }
}
