import {Controller} from "@hotwired/stimulus"
import Chart from 'chart.js/auto';
import SlimSelect from 'slim-select'
import mrujs from "mrujs";

// Connects to data-controller="dashboards"
export default class extends Controller {

    static targets = ['canvas', 'columnNames', 'groupBy']

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
        (async () => {
            // console.log('this.singleSelectItemsValue: ', this.singleSelectTarget.dataset.dashboardsSingleSelectItemsValue)

            // const columnNames = ['Order ID', 'Category', 'Currency'];
            // const queryParams = new URLSearchParams({column_names: columnNames});
            // mrujs.fetch(`/file_uploads/${id}/csv_rows.json?${queryParams}`)
            //     .then((response) => response.json())
            //     .then(data => {
            //         console.log("data: ", data)
            //     })
            //
            console.log("headers: ", this.headersValue)
            console.log("rows: ", this.rowsValue)

            const id = this.element.dataset.index;

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

            // new SlimSelect({
            //     select: this.singleSelectTarget,
            //     events: {
            //         afterChange: (newVal) => {
            //             console.log(newVal)
            //         }
            //     }
            // })

            new SlimSelect({
                select: this.columnNamesTarget,
                events: {
                    afterChange: async (newVal) => {
                        console.log(newVal)
                        const columnNames = newVal.map(res => res.text)
                        const csvRows = await this.fetchCsvRows(id, columnNames)
                        console.log("csv rows: ", csvRows)
                        // this.dropdownChanged(newVal)
                    }
                }
            })


            new SlimSelect({
                select: this.groupByTarget,
                events: {
                    afterChange: async (newVal) => {
                        console.log(newVal)
                        // const groupBy = newVal.map(res => res.text)
                        // const csvRows = await this.fetchCsvRows(id, columnNames)
                        // console.log("csv rows: ", csvRows)
                    }
                }
            })

            // this.choices = new Choices(this.singleSelectTarget);
            // console.log("choices: ", this.choices)

            // this.choices = new Choices(this.singleSelectTarget, {
            //     choices: JSON.parse(this.singleSelectTarget.dataset.dashboardsSingleSelectItemsValue),
            //     items: []
            // })
        })()
    }

    parameterizeUnderscore(name) {
        return name.toLowerCase()
            .replace(/[^\w\s]+|\s+/g, '_');
    }

    fetchCsvRows(id, columnNames) {
        const queryParams = new URLSearchParams({column_names: columnNames});
        return mrujs.fetch(`/file_uploads/${id}/csv_rows.json?${queryParams}`)
            .then((response) => response.json())

    }


    dropdownChanged(newVals) {
        this.removeDropdownContainers();

        // Loop through the selected fields
        newVals.forEach((newVal) => {
            const field = newVal.value;
            const dropdownOptions = ['sum', 'count', 'max', 'min'];
            const dropdownHtml = `
                <select>
                  ${dropdownOptions.map((option) => `<option value="${option}">${option}</option>`).join('')}
                </select>
              `;

            // console.log(this.element)
            // Create a new container and append the dropdown to it
            const container = document.createElement('div');
            container.id = `${field}-dropdown-container`;
            container.innerHTML = dropdownHtml;
            console.log("this.columnNamesTarget: ", this.columnNamesTarget)
            // this.element.appendChild(container); // Append the container after the multi-select element
            // this.columnNamesTarget.insertAdjacentElement('afterend', container);
            this.columnNamesTarget.parentElement.appendChild(container);
        });
    }

    removeDropdownContainers() {
        // Remove all existing dropdown containers
        const existingContainers = this.element.querySelectorAll('[id$="-dropdown-container"]');
        existingContainers.forEach((container) => container.remove());
    }
}
