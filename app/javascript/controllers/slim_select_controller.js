import {Controller} from "@hotwired/stimulus"
import SlimSelect from 'slim-select'
// Connects to data-controller="slim-select"
export default class extends Controller {

    static values = {
        settings: {
            type: Object,
            default: {}
        }
    };

    connect() {
        this.slimselect = new SlimSelect({
            select: this.element,
            settings: this.settingsValue,
            events: {
                addable: (value) => {
                    return {
                        text: value,
                        value: value
                    }
                }
            }

        });
    }

    disconnect() {
        this.slimselect.destroy();
    }
}
