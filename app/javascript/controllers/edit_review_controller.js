import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit-review"
export default class extends Controller {
  static targets = ["form", "flash"]

  open(event) {
    const reviewId = event.currentTarget.dataset.reviewId;
    const modalElement = document.getElementById('editReviewModal');

    if (!modalElement) {
      console.error('El elemento del modal no se encuentra en el DOM.');
      return;
    }

    fetch(`/reviews/${reviewId}/edit`)
      .then(response => response.text())
      .then(html => {
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');
        const formHtml = doc.querySelector('form').outerHTML;

        const modalBody = modalElement.querySelector('.modal-body');
        if (!modalBody) {
          console.error('No se encontró el elemento .modal-body en el modal.');
          return;
        }

        modalBody.innerHTML = formHtml;
        // modal.show();
      })
      .catch(error => console.error('Error al cargar el formulario:', error));
  }
}
