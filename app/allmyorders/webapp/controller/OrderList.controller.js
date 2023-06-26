sap.ui.define([
	"sap/ui/core/mvc/Controller",
	"sap/ui/model/json/JSONModel",
	"sap/m/Dialog",
	"sap/m/VBox",
	"sap/m/TextArea",
	"sap/m/CheckBox",
	"sap/m/Button",
	"sap/m/MessageToast",
	"sap/m/MessageBox",
	"sap/ui/core/message/Message",
	"sap/ui/core/library"
], function (
	Controller,
	JSONModel,
	Dialog,
	VBox,
	TextArea,
	CheckBox,
	Button,
	MessageToast,
	MessageBox,
	Message,
	library

) {
	"use strict";
	var MessageType = library.MessageType;
	return Controller.extend("ordermonitoring.allmyorders.controller.OrderList", {
		onInit: function () {

			this.getView().setModel(sap.ui.getCore().getMessageManager().getMessageModel(), "message");
			sap.ui.getCore().getMessageManager().registerObject(this.getView(), true);
			let smartTable = this.getView().byId("idSmartTable")
			smartTable.attachInitialise(((oEvent) => {
				oEvent.getSource()._oPersController.attachDialogAfterOpen((oEvent) => {
					this._dialogOpen = true
				})
				oEvent.getSource()._oPersController.attachDialogAfterClose((oEvent) => {
					if (!this._bCallSent) {
						this.getView().byId('idSmartFilter').fireSearch()
						this._dialogOpen = false;
					}
					this._bCallSent = false;
				})
			}))
			let oModel = new JSONModel();

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
							"salesOrder": this.getView().getModel().getProperty(oContext.sPath).VBELN,
							"salesOrderItem": this.getView().getModel().getProperty(oContext.sPath).POSNR
						})
					})
				} else if (oEvent.getParameter('rowIndex') === -1) {
					aSalesOrderTable = []
				}
				else {
					let sPath = oEvent.getParameters().rowContext.sPath;
					if (oEvent.getSource().isIndexSelected(oEvent.getParameter('rowIndex'))) {
						aSalesOrderTable.push({
							"salesOrder": this.getView().getModel().getProperty(sPath).VBELN,
							"salesOrderItem": this.getView().getModel().getProperty(sPath).POSNR
						})
					} else {
						aSalesOrderTable = aSalesOrderTable.filter((item) => {
							return item.salesOrder !== this.getView().getModel().getProperty(sPath).VBELN || item.salesOrderItem !== this.getView().getModel().getProperty(sPath).POSNR
						})
					}
				}
				this.getView().getModel('localModel').setProperty('/salesOrderTable', aSalesOrderTable);
			});
		},
		onMessagePopoverPress: function (oEvent) {
			var oSourceControl = oEvent.getSource();
			this._getMessagePopover().then(function (oMessagePopover) {
				oMessagePopover.openBy(oSourceControl);
			});
		},
		_getMessagePopover: function () {
			var oView = this.getView();

			// create popover lazily (singleton)
			if (!this._pMessagePopover) {
				this._pMessagePopover = sap.ui.core.Fragment.load({
					id: oView.getId(),
					name: "ordermonitoring.allmyorders.fragment.messagePopover"
				}).then(function (oMessagePopover) {
					oView.addDependent(oMessagePopover);
					return oMessagePopover;
				});
			}
			return this._pMessagePopover;
		},
		onBeforeRebindTable: function (oEvent) {
			let oBindingParams = oEvent.getParameter("bindingParams");
			sap.ui.getCore().getMessageManager().removeAllMessages();
			if (!oEvent.getParameter('bindingParams').filters.length) {
				this.getView().byId('idMsgManager').setIcon('sap-icon://alert')
				let oMessage = new Message({
					message: this._getText('noFilterSelected'),
					type: MessageType.Warning,
					target: "/Dummy",
					processor: this.getView().getModel()
				});
				sap.ui.getCore().getMessageManager().addMessages(oMessage);
				oMessage = new Message({
					message: this._getText('prevDataShown'),
					type: MessageType.Information,
					target: "/Dummy",
					processor: this.getView().getModel()
				});
				sap.ui.getCore().getMessageManager().addMessages(oMessage);
				oEvent.getParameter('bindingParams').preventTableBind = true
			}

			this.getView().getModel().setHeaders({ 'select': oEvent.getParameter('bindingParams').parameters.select })
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
			if (this._dialogOpen) {
				this._bCallSent = true;
			}
		},
		_onBindingDataRecievedListener: function (oEvent) {
			sap.ui.getCore().getMessageManager().removeAllMessages();
			let oMessage = new Message({
				message: this._getText('ResSuccess'),
				type: MessageType.Success,
				target: "/Dummy",
				processor: this.getView().getModel()
			});
			sap.ui.getCore().getMessageManager().addMessages(oMessage);
			this.getView().byId('idMsgManager').setIcon('sap-icon://message-success')
		},
		onAddNewNote: function (aContext, aaContext) {
			let oDialog = new Dialog({
				title: this._getText('changeCommentTitle'),
				type: sap.m.DialogType.Message,
				content: new VBox({
					items: [
						new TextArea({
							id:"idTextArea",
							value: "",
							cols: 100,
							maxLength: 1024,
							rows: 8
						})
					]
				}),
				beginButton: new Button({
					text: this._getText('save'),
					enabled: true,
					press: [function () {
						
						this._onAddComment();
						oDialog.close();
					}, this]
				}),
				endButton: new Button({
					text: this._getText('cancel'),
					press: function () {
						oDialog.close();
					}
				}),
				afterClose: function () {
					oDialog.destroy();
				}
			});
			this._oAddnote = oDialog ; 
			oDialog.open();
		},
		_onAddComment: function () {
			let oSalesTable = this.getView().getModel('localModel').getProperty('/salesOrderTable');
			oSalesTable.forEach((item) => {
				let sTitle = "Sales Order " + item.salesOrder;
				if (this._bOnHeader === true) {
					sTitle = "&CSEU&000000& " + sTitle;
				} else {
					sTitle = "&CSEU&" + item.salesOrderItem + "& " + sTitle;
				}
				let id = 24
				let creatItem = {
					ID: id + 1 ,
					CLIENT: '100',
					VBELN: item.salesOrder,
					POSNR: item.salesOrderItem,
					UTCTIME: Date.now(),
					LANGUAGE: 'E',
					NOTE_TITLE: sTitle,
					NOTE_TEXT: sap.ui.getCore().byId('idTextArea').getValue(),

				};
				this.getView().getModel().setDeferredGroups(["postComment"]);
				this.getView().getModel().create("/notes", creatItem, {
					groupId: "postComment"
				});
				
			})
			
				this.getView().getModel().submitChanges({
					groupId: "postComment",
					success:((oData)=> {
						this._oAddnote.close()
						MessageToast.show(this._getText('notesAdded'))
						this.getView().getModel().refresh();
					}),
					error: ((error)=> {
						var msg = JSON.parse(error.responseText).error.message.value;
						MessageToast.show(msg);
					})
				});
			

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

		},
		onAfterRendering: function () {
			this.getView().getModel().attachBatchRequestCompleted((oEvent) => { console.log(this); debugger; })
		}
	});
});