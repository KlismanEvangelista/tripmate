import { Application } from "@hotwired/stimulus"
import NavbarController from "./navbar_controller"
import ArrowController from "./arrow_controller"

const application = Application.start()
application.register('navbar', NavbarController)
application.register('scroll', ArrowController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
