import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="new-review"
export default class extends Controller {
  static targets = ["editor"]
  connect() {
    tinymce.init({
      selector: `.${this.editorTarget.dataset.richeditor}`,
      menubar: false,
      toolbar: 'bold italic backcolor | bullist numlist outdent indent | emoticons | removeformat | help', // Agrega 'emoticons' aquí
      plugins: 'lists emoticons',
      toolbar_mode: 'sliding',
      height: 250,
      setup: (editor) => {
        editor.on('change', () => {
          editor.save();
        });
      }
    });
  }
}
