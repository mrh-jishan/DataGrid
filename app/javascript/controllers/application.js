import {Application} from "@hotwired/stimulus"
import mrujs from "mrujs";
import {MrujsTurbo} from "mrujs/plugins"

const application = Application.start()
mrujs.start({
    plugins: [
        MrujsTurbo()
    ]
});

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export {application}
