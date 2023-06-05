sap.ui.define([
	"sap/ui/core/mvc/Controller",
	"sap/ui/model/json/JSONModel",
	"sap/m/Dialog",
	"sap/m/VBox",
	"sap/m/TextArea",
	"sap/m/CheckBox",
	"sap/m/Button",
	"sap/m/MessageToast",
	"sap/m/MessageBox"
], function (
	Controller,
	JSONModel,
	Dialog,
	VBox,
	TextArea,
	CheckBox,
	Button,
	MessageToast,
	MessageBox

) {
	"use strict";

	return Controller.extend("ordermonitoring.allmyorders.controller.OrderList", {
		onInit: function () {
			let smartTable = this.getView().byId("idSmartTable")
			smartTable.attachInitialise(((oEvent)=>{
				oEvent.getSource()._oPersController.attachDialogAfterOpen((oEvent)=>{
					
					this._dialogOpen = true
					
				})
				oEvent.getSource()._oPersController.attachDialogAfterClose((oEvent)=>{
					
					if(!this._bCallSent){
						this.getView().byId('idSmartFilter').fireSearch()
						this._dialogOpen = false;
						
					}
					this._bCallSent= false;
					
				})
			}))
			let oModel = new JSONModel();
			this.getView().byId("idSmartTable").getTable().setThreshold(10000000);
			oModel.setProperty('/orderSelected', false);
			this.getView().setModel(oModel, 'localModel');
			let oTable = this.getView().byId('idSmartTable').getTable();
			this.getView().getModel('localModel').setProperty('/salesOrderTable', [])
			oTable.attachRowSelectionChange((oEvent) => {
				let enabled = this.getView().byId('idSmartTable').getTable().getSelectedIndices().length === 0 ? false : true;
				this.getView().getModel('localModel').setProperty('/orderSelected', enabled);
				let aSalesOrderTable = this.getView().getModel('localModel').getProperty('/salesOrderTable');
				if (!aSalesOrderTable)
					aSalesOrderTable = [];
				if (oEvent.getParameter('selectAll')) {
					let aIndices = this.getView().byId('idSmartTable').getTable().getSelectedIndices();
					if (!aIndices.length) aSalesOrderTable = [];
					aIndices.forEach((index) => {
						let oContext = this.getView().byId('idSmartTable').getTable().getContextByIndex(index);
						aSalesOrderTable.push({
							"salesOrder": this.getView().getModel().getProperty(oContext.sPath).SalesOrder,
							"salesOrderItem": this.getView().getModel().getProperty(oContext.sPath).SalesOrderItem
						})
					})
				} else if (oEvent.getParameter('rowIndex') === -1) {
					aSalesOrderTable = []
				}
				else {
					let sPath = oEvent.getParameters().rowContext.sPath;
					if (oEvent.getSource().isIndexSelected(oEvent.getParameter('rowIndex'))) {
						aSalesOrderTable.push({
							"salesOrder": this.getView().getModel().getProperty(sPath).SalesOrder,
							"salesOrderItem": this.getView().getModel().getProperty(sPath).SalesOrderItem
						})
					} else {
						aSalesOrderTable = aSalesOrderTable.filter((item) => {
							return item.salesOrder !== this.getView().getModel().getProperty(sPath).SalesOrder || item.salesOrderItem !== this.getView().getModel().getProperty(sPath).SalesOrderItem
						})
					}
				}
				this.getView().getModel('localModel').setProperty('/salesOrderTable', aSalesOrderTable);
			});
		},
		onBeforeRebindTable: function (oEvent) {
			let oBindingParams = oEvent.getParameter("bindingParams");
			if (!oEvent.getParameter('bindingParams').filters.length){
				MessageBox.error(this._getText('noFilterSelected'))
				oEvent.getParameter('bindingParams').preventTableBind = true
			}

			this.addBindingListener(oBindingParams, "dataRequested", this._onBindingDataRequestedListener.bind(this))
			this.addBindingListener(oBindingParams, "dataReceived", this._onBindingDataRecievedListener.bind(this))
		},
		
		addBindingListener: function (oBindingInfo, sEventName, fHandler) {
			oBindingInfo.events = oBindingInfo.events || {};
			if (!oBindingInfo.events[sEventName]) {
				oBindingInfo.events[sEventName] = fHandler;
			} else {
				// Wrap the event handler of the other party to add our handler.
				var fOriginalHandler = oBindingInfo.events[sEventName];
				oBindingInfo.events[sEventName] = function () {
					fHandler.apply(this, arguments);
					fOriginalHandler.apply(this, arguments);
				};
			}
		},
		_onBindingDataRequestedListener: function (oEvent) {
			if (this._dialogOpen){
			this._bCallSent = true;
		}
			this.getView().byId("idSmartTable").getTable().setThreshold(10000000);
		},
		_onBindingDataRecievedListener: function(oEvent){
			debugger;
		},
		onAddNewNote: function (aContext, aaContext) {
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
		_onAddComment: function (sNewNote) {
			let oSalesTable = this.getView().getModel('localModel').getProperty('/salesOrderTable');
			oSalesTable.forEach((item) => {
				let sTitle = "Sales Order " + item.SalesOrder;
				if (this._bOnHeader === true) {
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
		onShowDetails: function (oEvent) {
			if (this.getView().byId('idSmartTable').getTable().getSelectedIndices().length > 1)
				return MessageBox.error(this._getText('selectOneRecord'))
			let selectedIndex = this.getView().byId('idSmartTable').getTable().getSelectedIndices()[0]
			let oContext = this.getView().byId('idSmartTable').getTable().getContextByIndex(selectedIndex);
			let oRow = this.getView().getModel().getProperty(oContext.sPath);
			let keyValuePair = this._createKeyValue(oRow);
			const field = `<strong>${this._getText('key')}</strong>`
			const value = `<strong>${this._getText('value')}</strong>`
			const salesOrder = keyValuePair.find(element => element.key === this._getText('SalesOrder'))
			const salesOrderItem = keyValuePair.find(element => element.key === this._getText('SalesOrderItem'))
			const title = `${this._getText('showingDetails', [salesOrder.value, salesOrderItem.value])}`
			const oModel = this.getView().getModel("localModel")
			oModel.setData({
				items: keyValuePair
			});
			oModel.setProperty('/field', field)
			oModel.setProperty('/value', value)
			oModel.setProperty('/title', title)
			this._openDetailsDialog();

		},
		_openDetailsDialog: function () {
			if (!this._showDetailsDialog) {
				this._showDetailsDialog = sap.ui.core.Fragment.load({
					id: "idShowDetails",
					name: "ordermonitoring.allmyorders.fragment.showDetails",
					controller: this
				}).then(function (oDialog) {
					return oDialog;
				});
			}
			this._showDetailsDialog.then(function (oDialog) {
				oDialog.open();
				this.getView().addDependent(oDialog);
			}.bind(this));
		},
		onSearch: function (oEvent) {
			let sValue = oEvent.getParameter("value");
			let oFilter = new sap.ui.model.Filter("key", "Contains", sValue);
			let oBinding = oEvent.getParameter("itemsBinding");
			oBinding.filter([oFilter]);
		},
		_createKeyValue: function (oRow) {
			let keyValuePair = [];
			for (const property in oRow) {
				let key = this._getText(property)
				if (oRow[property] instanceof Date) oRow[property] = oRow[property].toLocaleDateString()
				keyValuePair.push({
					key: key || property,
					value: oRow[property]
				})
			}
			return keyValuePair;
		},
		_getText: function (key, arr = []) {
			return this.getView().getModel('i18n').getResourceBundle().getText(key, arr);
		},
		onRowSelection: function (oEvent) {
			
		}
	});
});