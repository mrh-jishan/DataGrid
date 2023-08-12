import {Controller} from "@hotwired/stimulus"
import Chart from 'chart.js/auto';
import mrujs from "mrujs";
import Sortable from "sortablejs";

// Connects to data-controller="dashboards"
export default class extends Controller {

    static targets = ['canvas', 'headers', 'columnNames', 'groupBy']

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
            new Sortable(this.headersTarget, {
                animation: 150,
                group: {
                    name: 'shared',
                    pull: true,
                    put: true
                },
                onEnd: (ev) => onEndChange(ev),
            });

            const sortableColumnName = new Sortable(this.columnNamesTarget, {
                animation: 150,
                group: {
                    name: 'shared',
                    pull: true,
                    put: true
                },
                onEnd: (ev) => onEndChange(ev),
            });

            const sortableGroupBy = new Sortable(this.groupByTarget, {
                animation: 150,
                group: {
                    name: 'shared',
                    pull: true,
                    put: true,
                    // put: (to) => {
                    //     return to.el.children.length < 1;
                    // }
                },
                onEnd: (ev) => onEndChange(ev),
            });


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
            });

            const onEndChange = (ev) => {
                const columnNames = Array.from(sortableColumnName.el.children)
                    .reduce((accumulator, currentValue) => ({
                        ...accumulator,
                        [currentValue.dataset.name]: currentValue.dataset.type
                    }), {})

                const groupBy = Array.from(sortableGroupBy.el.children)
                    .reduce((accumulator, currentValue) => ({
                        ...accumulator,
                        [currentValue.dataset.name]: currentValue.dataset.type
                    }), {})

                const queryParams = new URLSearchParams({
                    column_names: encodeURIComponent(JSON.stringify(columnNames)),
                    group_by: encodeURIComponent(JSON.stringify(groupBy)),
                });
                const fileUploadId = this.element.dataset.index;
                mrujs.fetch(`/file_uploads/${fileUploadId}/csv_rows.json?${queryParams}`)
                    .then((response) => response.json())
                    .then(res => {
                        console.log("data: ", res)


                        //
                    })
            }

            // const mapData = (accumulator, currentValue) => ({
            //     ...accumulator,
            //     [currentValue.dataset.name]: currentValue.dataset.type
            // })


            // console.log("this happen here1", sortable1.toArray())
            // console.log("this happen here2", getData(sortableColumnName.el.children))
            // console.log("this happen here3", sortableGroupBy.el.children)

            // const columnNames = ['Order ID', 'Category', 'Currency'];
            // const queryParams = new URLSearchParams({column_names: columnNames});
            // mrujs.fetch(`/file_uploads/${fileUploadId}/csv_rows.json?${queryParams}`)
            //     .then((response) => response.json())
            //     .then(data => {
            //         console.log("data: ", data)
            //     })
            //
            // console.log("headers: ", this.headersValue)
            // console.log("rows: ", this.rowsValue)
            // const getData = (children) => Array.from(children)
            //     .map(el => `${el.dataset.name}|${el.dataset.type}`)

            // sortable1.on('end', () => {
            //     const allItems = sortable1.toArray();
            //     console.log('1All items:', allItems);
            //     // Perform any actions with the array of all items here
            // });
            //
            // sortableColumnName.on('end', () => {
            //     const allItems = sortable.toArray();
            //     console.log('2All items:', allItems);
            //     // Perform any actions with the array of all items here
            // });
            //
            // sortableGroupBy.on('end', () => {
            //     const allItems = sortable.toArray();
            //     console.log('3All items:', allItems);
            //     // Perform any actions with the array of all items here
            // });

            // new SlimSelect({
            //     select: this.singleSelectTarget,
            //     events: {
            //         afterChange: (newVal) => {
            //             console.log(newVal)
            //         }
            //     }
            // })

            // new SlimSelect({
            //     select: this.columnNamesTarget,
            //     events: {
            //         afterChange: async (newVal) => {
            //             console.log(newVal)
            //             const columnNames = newVal.map(res => res.text)
            //             const csvRows = await this.fetchCsvRows(id, columnNames)
            //             console.log("csv rows: ", csvRows)
            //             // this.dropdownChanged(newVal)
            //         }
            //     }
            // })
            //
            //
            // new SlimSelect({
            //     select: this.groupByTarget,
            //     events: {
            //         afterChange: async (newVal) => {
            //             console.log(newVal)
            //             // const groupBy = newVal.map(res => res.text)
            //             // const csvRows = await this.fetchCsvRows(id, columnNames)
            //             // console.log("csv rows: ", csvRows)
            //         }
            //     }
            // })

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

}


// onEnd: (ev) => onEndChange(ev),
// onMove: (ev) => onEndChange(ev),
// onMove: (evt, originalEvent) => {
// console.log('evt on move', evt);
// console.log('original on mve: ', originalEvent);
// return false
// }
// Add any other SortableJS options you may need


// console.log('this.singleSelectItemsValue: ', this.singleSelectTarget.dataset.dashboardsSingleSelectItemsValue)

// const columnNames = ['Order ID', 'Category', 'Currency'];
// const queryParams = new URLSearchParams({column_names: columnNames});
// mrujs.fetch(`/file_uploads/${id}/csv_rows.json?${queryParams}`)
//     .then((response) => response.json())
//     .then(data => {
//         console.log("data: ", data)
//     })
//
// console.log("headers: ", this.headersValue)
// console.log("rows: ", this.rowsValue)
// const id = this.element.dataset.index;

// onEnd: (ev) => onEndChange(ev),
// onAdd: (evt) => {
// console.log('Sorted fields:', evt);
// const allItems = Array.from(evt.to.children).map(item => {
//     return {
//         id: item.dataset.id,
//         name: item.innerText.trim(),
//     };
// });
// console.log('2---------:', allItems)
// }
// Add any other SortableJS options you may need
//     (evt) => {
//     // const sortedFields = Array.from(evt.to.children).map((field) => field.querySelector('input').name);
//     // const allItems = Array.from(evt.from.children)
//     // console.log('3  const allItems = Array.from(evt.from.children): ', allItems)
//     // console.log('Sorted fields:', evt);
// },
// onEnd: (ev) => onEndChange(ev),
// onAdd: (evt) => {
// const allItems = Array.from(evt.to.children).map(item => {
//     return {
//         id: item.dataset.id,
//         name: item.innerText.trim(),
//     };
// });
// console.log('3-------------:', allItems)
// }
// Add any other SortableJS options you may need