import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl";

// Connects to data-controller="start-point"
export default class extends Controller {
  static values = { apiKey: String, marker: String }

  connect() {
    // console.log("conectado")
    // console.log(this.markerValue)
    // console.log(JSON.parse(this.markerValue))
    // console.log(this.apiKeyValue)
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

  #addMarkersToMap() {
    this.marker = JSON.parse(this.markerValue)
    const popup = new mapboxgl.Popup().setHTML(this.marker.info_window_html)
    new mapboxgl.Marker()
      .setLngLat([ this.marker.lng, this.marker.lat ])
      .setPopup(popup)
      .addTo(this.map)
  }

  #fitMapToMarkers() {
    // if (this.marker) {
      const bounds = new mapboxgl.LngLatBounds()
      bounds.extend([this.marker.lng, this.marker.lat])
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
    // }
  }
}
