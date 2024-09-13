import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="start-point-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["startPoint"]

  connect() {
    console.log("tenemos conexion")

    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address",
      countries: "pe",
      autocomplete: true,
      fuzzyMatch: false
    })
    this.geocoder.addTo(this.element)

    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
  }

  disconnect() {
    this.geocoder.onRemove()
  }

  #setInputValue(event) {
    this.startPointTarget.value = event.result["place_name"]
  }

  #clearInputValue() {
    this.startPointTarget.value = ""
  }
}
