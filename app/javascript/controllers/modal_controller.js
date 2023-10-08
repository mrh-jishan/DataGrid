import {Controller} from "@hotwired/stimulus"
import {Modal} from "bootstrap"

// Connects to data-controller="modal"
export default class extends Controller {
    connect() {
        this.modal = new Modal(this.element)
    }

    open() {
        if (!this.modal.isOpened) {
            this.modal.show()
        }
    }

    close(event) {
        console.log("event--------: ", event)
        if (event.detail.success) {
            this.modal.hide()
        }
    }
}