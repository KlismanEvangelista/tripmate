import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {

  connect() {
    const urlParams = new URLSearchParams(window.location.search);
    const department = urlParams.get('department');

    if(department) {
      this.filterCardsByDepartment(department);
      this.activeDepartment(department)
    }
  }
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

    document.querySelector('.department-name').innerHTML = `${selectedDepartment} <i class="bi bi-trash3" data-action="click->map-filter#delete"></i>`
  }

  filterCardsByDepartment(selectedDepartment) {
    const cards = document.querySelectorAll(".plan-card");
    const container = document.querySelector(".container-cards");

    let visibleCards = 0;

    cards.forEach(card => {
      const cardDepartment = card.dataset.department;
      if (cardDepartment === selectedDepartment || selectedDepartment === 'all') {
        card.parentNode.style.setProperty('display', 'block', 'important');
        visibleCards++;
      } else {
        card.parentNode.style.setProperty('display', 'none', 'important');
      }
    });

    const noPlansMessage = container.querySelector('.no-plans-message');
    if (noPlansMessage) {
      noPlansMessage.remove();
    }

    if (visibleCards === 0) {
      const noPlansDiv = document.createElement('div');
      noPlansDiv.classList.add('text-center', 'no-plans-message', 'd-flex', 'flex-column');
      noPlansDiv.innerHTML = '<i class="bi bi-emoji-tear fs-1"></i> No hay planes disponibles para este departamento.';
      container.appendChild(noPlansDiv);
    }
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

  activeDepartment(department) {
    const departmentElement = document.querySelector(`[data-department='${department}']`);

    if (departmentElement) {
      if (this.previousTarget) {
        this.previousTarget.style.fill = "";
      }

      departmentElement.style.fill = "#04477e";
      this.previousTarget = departmentElement;
    }
  }

  delete() {
    const cards = document.querySelectorAll(".plan-card");
    const container = document.querySelector(".container-cards");

    cards.forEach(card => {
      card.parentNode.style.setProperty('display', 'block', 'important');
    });
    document.querySelector('.department-name').innerHTML = '';

    if (this.previousTarget) {
      this.previousTarget.style.fill = "";
    }
    const noPlansMessage = container.querySelector('.no-plans-message');
    if (noPlansMessage) {
      noPlansMessage.remove();
    }
  }
}
