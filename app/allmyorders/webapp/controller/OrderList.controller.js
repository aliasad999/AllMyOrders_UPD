sap.ui.define([
	"sap/ui/core/mvc/Controller",
	"sap/ui/model/json/JSONModel",
	"sap/m/Dialog",
	"sap/m/VBox",
	"sap/m/TextArea",
	"sap/m/Button",
	"sap/m/MessageToast",
	"sap/m/MessageBox",
	"sap/ui/core/message/Message",
	"sap/ui/core/library",
	"sap/m/MessageStrip"
], function (
	Controller,
	JSONModel,
	Dialog,
	VBox,
	TextArea,
	Button,
	MessageToast,
	MessageBox,
	Message,
	library,
	MessageStrip

) {
	"use strict";
	var MessageType = library.MessageType;
	return Controller.extend("ordermonitoring.allmyorders.controller.OrderList", {
		onInit: function () {
			this.oRouter = this.getOwnerComponent().getRouter();
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
			oModel.setProperty('/orderSelectedSingle', false);
			this.getView().setModel(oModel, 'localModel');
			let oTable = this.getView().byId('idSmartTable').getTable();
			this.getView().getModel('localModel').setProperty('/salesOrderTable', [])
			oTable.attachRowSelectionChange((oEvent) => {
				let enabled = this.getView().byId('idSmartTable').getTable().getSelectedIndices().length === 0 ? false : true;
				let SingleEnabled = this.getView().byId('idSmartTable').getTable().getSelectedIndices().length === 1 ? true : false;
				this.getView().getModel('localModel').setProperty('/orderSelected', enabled);
				this.getView().getModel('localModel').setProperty('/orderSelectedSingle', SingleEnabled);
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
		onBeforeRebindTable: function (oEvent) {
			let oBindingParams = oEvent.getParameter("bindingParams");
			sap.ui.getCore().getMessageManager().removeAllMessages();
			if (!oEvent.getParameter('bindingParams').filters.length) {
				this.getView().getModel('localModel').setProperty('/msgVisible', true);
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
			} else {
				this.getView().getModel('localModel').setProperty('/msgVisible', false);
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
		onRowSelChange: function(oEvent){
			let salesOrder = this.getView().getModel().getProperty(oEvent.getParameter("row").getBindingContext().sPath).VBELN
			let orderItem = this.getView().getModel().getProperty(oEvent.getParameter("row").getBindingContext().sPath).POSNR
			this._navToNotes(salesOrder,orderItem);
		},
		onAddNewNote: function (aContext, aaContext) {
			let oDialog = new Dialog({
				title: this._getText('changeCommentTitle'),
				type: sap.m.DialogType.Message,
				content: new VBox({
					items: [
						new MessageStrip({
							text:this._getText('langInfo'),
							showIcon:true
						}),
						new TextArea({
							id: "idTextArea",
							value: "",
							cols: 100,
							maxLength: 1024,
							rows: 8
						})
					]
				}),
				beginButton: new Button({
					text: this._getText('cancel'),
					press: function () {
						oDialog.close();
					}
				}),
				endButton:new Button({
					text: this._getText('save'),
					enabled: true,
					type: "Emphasized",
					press: [function () {

						this._onAddComment();
						oDialog.close();
					}, this]
				}),
				afterClose: function () {
					oDialog.destroy();
				}
			});
			this._oAddnote = oDialog;
			oDialog.open();
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
		onSearch: function (oEvent) {
			let sValue = oEvent.getParameter("value");
			let oFilter = new sap.ui.model.Filter("key", "Contains", sValue);
			let oBinding = oEvent.getParameter("itemsBinding");
			oBinding.filter([oFilter]);
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
		onShowAllNotes: function (oEvent) {
			let salesOrder = this.getView().getModel('localModel').getProperty('/salesOrderTable')[0].salesOrder;
			let orderItem = this.getView().getModel('localModel').getProperty('/salesOrderTable')[0].salesOrderItem;
			this._navToNotes(salesOrder,orderItem)
			
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
				let creatItem = {
					CLIENT: '100',
					VBELN: item.salesOrder,
					POSNR: item.salesOrderItem,
					UTCTIME: Date.now(),
					LANGUAGE: sap.ui.getCore().getConfiguration().getLanguage().split('-')[0].toUpperCase(),
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
				success: ((oData) => {
					if (oData.__batchResponses[0].__changeResponses[0].statusCode === '200' || oData.__batchResponses[0].__changeResponses[0].statusCode === '201') {
						MessageToast.show(this._getText('notesAdded'))
						this.getView().getModel().refresh();
					} else {
						let oMessage = new Message({
							message: this._getText('notesNotAdded'),
							type: MessageType.Success,
							target: "/Dummy",
							processor: this.getView().getModel()
						});
						sap.ui.getCore().getMessageManager().addMessages(oMessage);
					}
				}),
				error: ((error) => {
					var msg = JSON.parse(error.responseText).error.message.value;
					let oMessage = new Message({
						message: msg,
						type: MessageType.Success,
						target: "/Dummy",
						processor: this.getView().getModel()
					});
					sap.ui.getCore().getMessageManager().addMessages(oMessage);

				})
			});
		},
		_navToNotes: function(salesOrder,orderItem){
			this.oRouter.navTo("notes", { salesOrder: salesOrder, orderItem: orderItem});
		}
	});
});