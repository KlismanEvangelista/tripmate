import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autocomplete-address"
export default class extends Controller {
  static values = { apikey: String }
  static targets = [ 'address' ]

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apikeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address",
      countries: "pe",
      autocomplete: true,
      fuzzyMatch: false
    });

    this.geocoder.addTo(this.element)
    this.geocoder.on("result", event => this.#setInputValue(event));
    this.geocoder.on("clear", () => this.#clearInputValue());
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"];
  }

  #clearInputValue() {
    this.addressTarget.value = "";
  }

  disconnect() {
    this.geocoder.onRemove();
  }
}
