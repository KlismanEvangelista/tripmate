import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  initialize() {
    this.previousTarget = null;
  }

  filter(event) {
    const selectedDepartment = event.currentTarget.dataset.department;
    console.log(event.currentTarget.dataset);

    if (this.previousTarget) {
      this.previousTarget.style.fill = "";
    }

    event.currentTarget.style.fill = "#04477e";

    this.previousTarget = event.currentTarget;
  }

  mouseover(event) {
    const svg = event.currentTarget;

    svg.style.fill = "#04477e";
  }

  mouseout(event) {
    const svg = event.currentTarget;

    if (svg !== this.previousTarget) {
      svg.style.fill = "";
    }
  }
}
