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
        headers: [],
        rows: []
    }

    connect() {

        // console.log('this.singleSelectItemsValue: ', this.singleSelectTarget.dataset.dashboardsSingleSelectItemsValue)

        console.log("headers: ", this.headersValue)
        console.log("rows: ", this.rowsValue)

        let data = {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'AUG'],
            datasets: [{
                label: 'My First dataset',
                // backgroundColor: 'transparent',
                // borderColor: '#3B82F6',
                data: [37, 83, 78, 54, 12, 5, 99, 100],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(255, 159, 64, 0.2)',
                    'rgba(255, 205, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(201, 203, 207, 0.2)'
                ],
                borderColor: [
                    'rgb(255, 99, 132)',
                    'rgb(255, 159, 64)',
                    'rgb(255, 205, 86)',
                    'rgb(75, 192, 192)',
                    'rgb(54, 162, 235)',
                    'rgb(153, 102, 255)',
                    'rgb(201, 203, 207)'
                ],
                borderWidth: 1
            }]
        }

        // this.dataValue,

        const ctx = this.canvasTarget.getContext('2d');
        new Chart(ctx, {
            type: this.typeValue,
            data: data,
            options: {
                plugins: {
                    legend: {
                        onClick: () => false, // Disable click events on legend labels
                    },
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
            // this.optionsValue,
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
