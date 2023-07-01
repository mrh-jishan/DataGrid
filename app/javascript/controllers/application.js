import { Application } from "@hotwired/stimulus"
import mrujs from "mrujs";

const application = Application.start()
mrujs.start();

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
