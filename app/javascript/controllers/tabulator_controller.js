import {Controller} from "@hotwired/stimulus"
import {TabulatorFull as Tabulator} from 'tabulator-tables';
import mrujs from 'mrujs';

// Connects to data-controller="tabulator"
export default class extends Controller {
    static targets = ["table"]

    connect() {
        const id = this.element.dataset.index;
        const table = new Tabulator(this.tableTarget, {
            // height: 450, // set height of table (in CSS or here), this enables the Virtual DOM and improves render speed dramatically (can be any valid css height value)
            layout: "fitData",
            pagination: true, //enable pagination
            paginationMode: "remote",
            ajaxURL: `/file_uploads/${id}.json`, //ajax URL


            autoColumns:true,
            // "columns":[{"title":"Index","field":"Index","width":150},{"title":"Customer Id","field":"Customer Id","width":150},{"title":"First Name","field":"First Name","width":150},{"title":"Last Name","field":"Last Name","width":150},{"title":"Company","field":"Company","width":150},{"title":"City","field":"City","width":150},{"title":"Country","field":"Country","width":150},{"title":"Phone 1","field":"Phone 1","width":150},{"title":"Phone 2","field":"Phone 2","width":150},{"title":"Email","field":"Email","width":150},{"title":"Subscription Date","field":"Subscription Date","width":150},{"title":"Website","field":"Website","width":150}]
            // columns: [{"title": "Index", "field": "Index"}, {
            //     "title": "Customer Id",
            //     "field": "Customer Id"
            // }, {"title": "First Name", "field": "First Name"}, {
            //     "title": "Last Name",
            //     "field": "Last Name"
            // }, {"title": "Company", "field": "Company"}, {"title": "City", "field": "City"}, {
            //     "title": "Country",
            //     "field": "Country"
            // }, {"title": "Phone 1", "field": "Phone 1"}, {"title": "Phone 2", "field": "Phone 2"}, {
            //     "title": "Email",
            //     "field": "Email"
            // }, {"title": "Subscription Date", "field": "Subscription Date"}, {"title": "Website", "field": "Website"}]
        });

        //trigger an alert message when the row is clicked
        table.on("rowClick", function (e, row) {
            alert("Row " + row.getData().id + " Clicked!!!!");
        });

        // this.fetchData();
    }

    // fetchData() {
    //     const id = this.element.dataset.index;
    //     console.log("data id: ", id)
    //     mrujs.fetch(`/file_uploads/${id}.json`)
    //         .then((response) => response.json())
    //         .then((data) => {
    //             console.log("data: ", data)
    //             // this.outputTarget.textContent = JSON.stringify(data);
    //         })
    //         .catch((error) => {
    //             console.error("Error fetching data:", error);
    //         });
    // }
    // const tabledata = [
    //     {id: 1, name: "Oli Bob", age: "12", col: "red", dob: ""},
    //     {id: 2, name: "Mary May", age: "1", col: "blue", dob: "14/05/1982"},
    //     {id: 3, name: "Christine Lobowski", age: "42", col: "green", dob: "22/05/1982"},
    //     {id: 4, name: "Brendon Philips", age: "125", col: "orange", dob: "01/08/1980"},
    //     {id: 5, name: "Margret Marmajuke", age: "16", col: "yellow", dob: "31/01/1999"},
    // ];
    // data: tabledata, //assign data to table
    // layout: "fitColumns", //fit columns to width of table (optional)
    // columns: [ //Define Table Columns
    //     {title: "Name", field: "name", width: 150},
    //     {title: "Age", field: "age", hozAlign: "left", formatter: "progress"},
    //     {title: "Favourite Color", field: "col"},
    //     {title: "Date Of Birth", field: "dob", hozAlign: "center"},
    // ],
}
