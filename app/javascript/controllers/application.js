import { Application } from "@hotwired/stimulus"
import NavbarController from "./navbar_controller"
import ArrowController from "./arrow_controller"
import HomeController from "./home_controller"
import FlatpickrController from "./flatpickr_controller"
import MapController from "./map_controller"

const application = Application.start()
application.register('navbar', NavbarController)
application.register('scroll', ArrowController)
application.register('home', HomeController)
application.register('map-filter', MapController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
