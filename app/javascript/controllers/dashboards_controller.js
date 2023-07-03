import {Controller} from "@hotwired/stimulus"
import Chart from 'chart.js/auto';
import SlimSelect from 'slim-select'

// Connects to data-controller="dashboards"
export default class extends Controller {

    static targets = ['canvas', 'singleSelect', 'multiSelect']

    static values = {
        type: {
            type: String,
            default: 'line'
        },
        data: Object,
        options: Object,
        singleSelectItems: []
    }

    connect() {

        // console.log('this.singleSelectItemsValue: ', this.singleSelectTarget.dataset.dashboardsSingleSelectItemsValue)

        const ctx = this.canvasTarget.getContext('2d');
        new Chart(ctx, {
            type: this.typeValue,
            data: this.dataValue,
            options: this.optionsValue,
        });

        new SlimSelect({
            select: this.singleSelectTarget,
            events: {
                afterChange: (newVal) => {
                    console.log(newVal)
                }
            }
        })

        new SlimSelect({
            select: this.multiSelectTarget,
            events: {
                afterChange: (newVal) => {
                    console.log(newVal)
                }
            }
        })

        // this.choices = new Choices(this.singleSelectTarget);
        // console.log("choices: ", this.choices)

        // this.choices = new Choices(this.singleSelectTarget, {
        //     choices: JSON.parse(this.singleSelectTarget.dataset.dashboardsSingleSelectItemsValue),
        //     items: []
        // })

    }
}
