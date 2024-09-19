import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["step", "editor", "startDate", "endDate", "input", "preview"]

  connect() {
    this.currentStep = 0
    this.updateStep()

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

    flatpickr(this.startDateTarget, {
      dateFormat: "Y-m-d",
      enableTime: false,
      minDate: "today",
      locale: "es",
      onChange: this.updateEndDate.bind(this)
    });

    flatpickr(this.endDateTarget, {
      dateFormat: "Y-m-d",
      enableTime: false,
      minDate: "today",
      dateFormat: "Y-m-d",
      locale: "es"
    });

    this.updatePreviews();
  }

  nextStep(event) {
    event.preventDefault()
    if (this.isValid()) {
      this.currentStep++
      this.updateStep()
    } else {
      return
    }
  }

  prevStep(event) {
    event.preventDefault()
    this.currentStep--
    this.updateStep()
  }

  updateStep() {
    const steps = document.querySelectorAll('.step-item');
    steps.forEach(step => {
      const stepNumber = parseInt(step.getAttribute('data-step'));
      if (stepNumber <= this.currentStep) {
        step.classList.add('active');
      } else {
        step.classList.remove('active');
      }
    });

    this.stepTargets.forEach((step, index) => {
      step.classList.toggle('d-none', index !== this.currentStep)
    })
  }

  isValid() {
    const currentForm = this.stepTargets[this.currentStep]
    const inputs = currentForm.querySelectorAll('.required-input')
    let valid = true

    inputs.forEach(input => {
      if (input.value.trim() === '') {
        valid = false
        input.classList.add('is-invalid')
      } else {
        input.classList.remove('is-invalid')
      }
    })

    return valid
  }

  updateEndDate(dateStr) {
    const minDate = dateStr;
    this.endDateTarget._flatpickr.set("minDate", minDate);
  }

  updatePreviews() {
    this.inputTarget.addEventListener('change', (event) => {
      const files = event.target.files;
      this.previewTarget.innerHTML = '';

      Array.from(files).forEach(file => {
        const reader = new FileReader();

        reader.onload = (e) => {
          const img = document.createElement('img');
          img.src = e.target.result;
          img.className = 'photo-thumbnail';

          const container = document.createElement('div');
          container.className = 'photo-thumbnail-container';
          container.appendChild(img);

          const removeBtn = document.createElement('button');
          removeBtn.className = 'remove-btn';
          removeBtn.innerText = 'X';
          removeBtn.addEventListener('click', () => {
            container.remove();
          });

          container.appendChild(removeBtn);
          this.previewTarget.appendChild(container);
        };

        reader.readAsDataURL(file);
      });
    });
  }

}
