import {Controller} from "@hotwired/stimulus"
import Choices from "choices.js";

// Connects to data-controller="choices"
export default class extends Controller {

    static values = {
        items: []
    }

    connect() {
        this.choices = new Choices(this.element, {
            choices: this.itemsValue
        })
    }
}
