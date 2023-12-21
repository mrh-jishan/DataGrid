import {Controller} from "@hotwired/stimulus"
import flatpickr from "flatpickr";
// Connects to data-controller="flatpickr"
export default class extends Controller {

    static targets = ['flatpickr']

    static values = {
        options: {
            type: Object,
            default: {}
        }
    };

    connect() {
        const element = this.hasFlatpickrTarget ? this.flatpickrTarget : this.element
        flatpickr(element, this.optionsValue);
    }
}
