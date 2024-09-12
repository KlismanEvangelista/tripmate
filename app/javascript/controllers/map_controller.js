import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  initialize() {
    this.previousTarget = null;
  }

  filter(event) {
    const selectedDepartment = event.currentTarget.dataset.department;

    if (this.previousTarget) {
      this.previousTarget.style.fill = "";
    }

    event.currentTarget.style.fill = "#04477e";

    this.previousTarget = event.currentTarget;

    this.filterCardsByDepartment(selectedDepartment);
    }

  filterCardsByDepartment(selectedDepartment) {
    console.log(selectedDepartment);
    const cards = document.querySelectorAll(".plan-card");

    cards.forEach(card => {
      const cardDepartment = card.dataset.department;
      if (cardDepartment === selectedDepartment) {
        card.parentNode.style.setProperty('display', 'block', 'important');
      } else {
        card.parentNode.style.setProperty('display', 'none', 'important');
      }
    });
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
