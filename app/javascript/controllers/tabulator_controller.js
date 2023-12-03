import {Controller} from "@hotwired/stimulus"
import {TabulatorFull as Tabulator} from 'tabulator-tables';
import mrujs from 'mrujs';

// Connects to data-controller="tabulator"
export default class extends Controller {
    static targets = ["table"]

    connect() {
        (async () => {
            const id = this.element.dataset.index;
            new Tabulator(this.element, {
                columnDefaults:{
                    tooltip:true,
                },
                layout: "fitData",
                pagination: true, //enable pagination
                paginationMode: "remote",
                height:"calc(100vh - 115px)",
                ajaxURL: `/datasets/${id}.json`, //ajax URL
                columns: await this.fetchColumns(id)
            });
        })()
    }

    fetchColumns = (id) => {
        return mrujs.fetch(`/datasets/${id}/csv_headers.json`)
            .then((response) => response.json())
    }
}
