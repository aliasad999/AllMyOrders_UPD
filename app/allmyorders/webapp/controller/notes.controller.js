sap.ui.define([
    "sap/ui/model/json/JSONModel",
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/Filter",
    "sap/ui/model/FilterOperator",
    "sap/m/MessageBox",
], function (JSONModel, Controller, Filter, FilterOperator, MessageBox) {
    "use strict";

    return Controller.extend("ordermonitoring.allmyorders.controller.notes", {
        onInit: function () {
            let oModel = new JSONModel();
            this.getView().setModel(oModel, 'viewModel');
            this.oRouter = this.getOwnerComponent().getRouter();
            this.oRouter.getRoute("notes").attachPatternMatched(this._showNotes, this);

        },
        handleClose: function () {
            this.oRouter.navTo("SalesOrders");
        },
        handleRefresh: function (oEvent) {
            this._readNotes();
        },
        _showNotes: function (oEvent) {
            let salesOrder = oEvent.getParameter("arguments").salesOrder
            let orderItem = oEvent.getParameter("arguments").orderItem
            this.getView().getModel('viewModel').setProperty('/salesOrder', salesOrder)
            this.getView().getModel('viewModel').setProperty('/orderItem', orderItem)
            this._readNotes()
        },
        _readNotes: function () {
            this.getView().setBusy(true)
            let text = ""
            let oFilter = new Filter({
                filters: [
                    new Filter({
                        path: "VBELN",
                        operator: FilterOperator.EQ,
                        value1: this.getView().getModel('viewModel').getProperty('/salesOrder')
                    }),
                    new Filter({
                        path: "POSNR",
                        operator: FilterOperator.EQ,
                        value1: this.getView().getModel('viewModel').getProperty('/orderItem')
                    })
                ],
                and: true
            });
            this.getView().getModel().read('/notes', {
                filters: [oFilter],
                success: ((data) => {
                    data.results.forEach((item) => {
                        let date = new Date(parseInt(item.UTCTIME))
                        text = `${text} ${item.NOTE_TEXT}\n note language is: ${item.LANGUAGE}\tit was created at: ${date}\n\n`
                    })
                    this.getView().setBusy(false)
                    this.getView().getModel('viewModel').setProperty('/text', text);
                }),
                error: ((error) => {
                    this.getView().setBusy(false);
                    MessageBox.error(error)
                    this.getView().getModel('viewModel').setProperty('/text', '');
                })
            })

        }
    })
});