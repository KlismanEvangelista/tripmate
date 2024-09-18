import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="review"
export default class extends Controller {
  connect() {
  }

  open(event) {
    console.log(this.formTarget)
    const reviewId = event.currentTarget.dataset.reviewId;

    fetch(`/reviews/${reviewId}/edit`)
      .then(response => response.text())
      .then(html => {
        this.formTarget.innerHTML = html;

        const modal = new Modal(document.getElementById('editReviewModal'));
        modal.show();
      })
      .catch(error => console.error('Error loading form:', error));
  }
}
