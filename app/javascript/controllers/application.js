import {Application} from "@hotwired/stimulus"
import mrujs from "mrujs";
import * as bootstrap from "bootstrap"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application
mrujs.start();


export {application}
