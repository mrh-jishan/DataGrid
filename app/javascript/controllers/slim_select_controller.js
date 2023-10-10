import {Controller} from "@hotwired/stimulus"
import SlimSelect from 'slim-select'
// Connects to data-controller="slim-select"
export default class extends Controller {
    static values = {
        options: Object
    };

    connect() {
        this.slimselect = new SlimSelect({
            select: this.element,
        });
    }

    disconnect() {
        this.slimselect.destroy();
    }
}
