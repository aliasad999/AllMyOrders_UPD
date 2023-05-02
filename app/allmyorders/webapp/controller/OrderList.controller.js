sap.ui.define([
	"sap/ui/core/mvc/Controller",
	"sap/ui/model/json/JSONModel",
	"sap/m/Dialog",
	"sap/m/VBox",
	"sap/m/TextArea",
	"sap/m/CheckBox",
	"sap/m/Button",
	"sap/m/MessageToast"
], function(
	Controller,
	JSONModel,
	Dialog,
	VBox,
	TextArea,
	CheckBox,
	Button,
	MessageToast

) {
	"use strict";

	return Controller.extend("ordermonitoring.allmyorders.controller.OrderList", {
		onInit: function(){
			let oModel = new JSONModel();
			oModel.setProperty('/orderSelected', false);
			this.getView().setModel(oModel,'localModel');
			let oTable = this.getView().byId('idSmartTable').getTable();
			this.getView().getModel('localModel').setProperty('/salesOrderTable',[])
			oTable.attachRowSelectionChange((oEvent)=>{
				let enabled = this.getView().byId('idSmartTable').getTable().getSelectedIndices().length === 0 ? false : true;
				this.getView().getModel('localModel').setProperty('/orderSelected',enabled);
				let aSalesOrderTable = this.getView().getModel('localModel').getProperty('/salesOrderTable');
				let sPath = oEvent.getParameters().rowContext.sPath;
				if (oEvent.getSource().isIndexSelected(oEvent.getParameter('rowIndex'))){
					aSalesOrderTable.push({	"salesOrder"	: this.getView().getModel().getProperty(sPath).SalesOrder,
											"salesOrderItem": this.getView().getModel().getProperty(sPath).SalesOrderItem})
				}else{
					aSalesOrderTable = aSalesOrderTable.filter((item)=>{return item.salesOrder !==  this.getView().getModel().getProperty(sPath).SalesOrder || item.salesOrderItem !== this.getView().getModel().getProperty(sPath).SalesOrderItem })
				}
				this.getView().getModel('localModel').setProperty('/salesOrderTable',aSalesOrderTable);
		});
	},
		onAddNewNote: function(aContext,aaContext){
			let oDialog = new Dialog({
				title: '{i18n>changeCommentTitle}',
				type: sap.m.DialogType.Message,
				content: new VBox({
					items: [
						new TextArea({
							value: "",
							cols: 100,
							maxLength: 1024,
							rows: 8
						}),
						new CheckBox({
							selected: false,
							text: '{i18n>onHeaderLevel}'
						})
					]
				}),
				beginButton: new Button({
					text: '{i18n>AddCommentApply}',
					enabled: true,
					press: [function () {
						var sNewNote = oDialog.getContent()[0].getItems()[0].getValue().trim();
						this._bOnHeader = oDialog.getContent()[0].getItems()[1].getSelected();
						this._onAddComment(sNewNote);
						oDialog.close();
					}, this]
				}),
				endButton: new Button({
					text: 'Cancel Comment',
					press: function () {
						oDialog.close();
					}
				}),
				afterClose: function () {
					oDialog.destroy();
				}
			});
			oDialog.open();
		},
		_onAddComment: function(sNewNote){
			let oSalesTable = this.getView().getModel('localModel').getProperty('/salesOrderTable');
			oSalesTable.forEach((item)=>{
			let sTitle = "Sales Order " + item.SalesOrder;
				if (this._bOnHeader === true ) {
					sTitle = "&CSEU&000000& " + sTitle;
				} else {
					sTitle = "&CSEU&" + item.SalesOrderItem + "& " + sTitle;
				}
			let creatItem = {
				SalesOrderID: item.salesOrder,
				Title: sTitle,
				Content: sNewNote
			};
			this.getView().getModel("NotesModel").setDeferredGroups(["postComment"]);
			this.getView().getModel("NotesModel").create("/NoteSet", creatItem, {
				groupId: "postComment"
			});
			this.getView().getModel("NotesModel").submitChanges({

				groupId: "postComment",
				success: function (oData) {
					debugger;

				},
				error: function (error) {
					var msg = JSON.parse(error.responseText).error.message.value;
					MessageToast.show(msg);
				}
			});
		})
			
		},
		onRowSelection: function(oEvent){
			debugger;
		}
	});
});