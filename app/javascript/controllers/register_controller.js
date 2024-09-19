import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="register"
export default class extends Controller {
  static targets = ["form", "date"]

  connect() {
    const initialDate = this.dateTarget.value || null;
    const today = new Date();
    const eighteenYearsAgo = new Date(today.getFullYear() - 18, today.getMonth(), today.getDate());

    flatpickr(this.dateTarget, {
      enableTime: false,
      dateFormat: "d-m-Y",
      defaultDate: initialDate,
      locale: "es",
      allowInput: true,
      maxDate: eighteenYearsAgo,
    });

  }
}
