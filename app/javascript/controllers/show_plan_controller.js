import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-plan"
export default class extends Controller {
  connect() {

    // Inicializa el carrusel principal
    this.splide = new Splide('#main-carousel', {
      pagination: false,
      autoplay: true,
      type: 'loop'
    });

    // Selecciona las miniaturas
    this.thumbnails = document.getElementsByClassName('miniatura');
    this.currentThumbnail = null;

    // Inicializa el evento para cada miniatura
    this.initializeThumbnails();

    // Añadir el evento al movimiento del carrusel
    this.splide.on('move mounted', this.updateActiveThumbnail.bind(this));

    // Montar el carrusel
    this.splide.mount();
  }

  // Inicializa el evento de clic en cada miniatura
  initializeThumbnails() {
    for (let i = 0; i < this.thumbnails.length; i++) {
      this.addClickEventToThumbnail(this.thumbnails[i], i);
    }
  }

  // Agrega el evento de clic a la miniatura
  addClickEventToThumbnail(thumbnail, index) {
    thumbnail.addEventListener('click', () => {
      this.splide.go(index);
    });
  }

  // Actualiza la miniatura activa cuando el carrusel se mueve
  updateActiveThumbnail() {
    const activeThumbnail = this.thumbnails[this.splide.index];

    if (activeThumbnail) {
      if (this.currentThumbnail) {
        this.currentThumbnail.classList.remove('is-active');
      }

      activeThumbnail.classList.add('is-active');
      this.currentThumbnail = activeThumbnail;
    }
  }
}
