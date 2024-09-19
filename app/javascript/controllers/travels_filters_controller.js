import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="travels-filters"
export default class extends Controller {
  static targets = ["todos"]
  connect() {
  }

  filter(event){
    event.preventDefault()
    const allFilters = this.element.querySelectorAll('[data-travels-filters-target]');
    allFilters.forEach(filter => filter.classList.remove('active'));

    const all = this.todosTarget.dataset["travelsFiltersTarget"];
    const travelCards = this.element.querySelectorAll('.travel-container');

    const activeFilter = event.currentTarget.dataset.travelsFiltersTarget;

    event.currentTarget.classList.add('active');

    travelCards.forEach(card => {
      const data = card.querySelector('[data-travels-filters-status-value]');
      if (data) {
        const status = data.dataset["travelsFiltersStatusValue"]
        if ( activeFilter === all ) {
          card.classList.remove('d-none');
        } else if ( status === activeFilter ) {
          card.classList.remove('d-none')
        } else {
          card.classList.add('d-none');
        }
      } else {
        card.classList.remove('d-none');
      }
    });
  }
}
