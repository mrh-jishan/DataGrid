import {Controller} from "@hotwired/stimulus"
import Chart from 'chart.js/auto';

// Connects to data-controller="dashboards"
export default class extends Controller {

    static values = {
        type: {
            type: String,
            default: 'line'
        },
        data: Object,
        options: Object
    }

    connect() {
        // Create a new chart using the chart data
        const ctx = this.element.getContext('2d');
        new Chart(ctx, {
            type: this.typeValue,
            data: this.dataValue,
            options: this.optionsValue,
        });
    }
}
