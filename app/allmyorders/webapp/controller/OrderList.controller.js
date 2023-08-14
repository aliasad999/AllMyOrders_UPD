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
	"sap/m/MessageStrip",
	"sap/ui/model/Filter",
	"sap/ui/model/FilterOperator"
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
	MessageStrip,
	Filter,
	FilterOperator

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
			oModel.setProperty('/CurrentUser', sap.ushell.Container.getService("UserInfo").getUser().getId());

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

		onBeforeRendering: function (ctx) { },

		onAfterRendering: function (ctx) { },

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
			this.getView().getModel().setHeaders({ 'select': oEvent.getParameter('bindingParams').parameters.select, 'active-user': this.getView().getModel('localModel').getProperty('/CurrentUser') });




			if (oEvent.getParameter('bindingParams').parameters.select.includes('CHARG')) {
				oEvent.getParameter('bindingParams').parameters.select = `${oEvent.getParameter('bindingParams').parameters.select},HSDAT_DATE,VFDAT_DATE`
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
		onRowSelChange: function (oEvent) {
			let salesOrder = this.getView().getModel().getProperty(oEvent.getParameter("row").getBindingContext().sPath).VBELN
			let orderItem = this.getView().getModel().getProperty(oEvent.getParameter("row").getBindingContext().sPath).POSNR
			this._navToNotes(salesOrder, orderItem);
		},
		onAddNewNote: function (aContext, aaContext) {
			let oDialog = new Dialog({
				title: this._getText('changeCommentTitle'),
				type: sap.m.DialogType.Message,
				content: new VBox({
					items: [
						new MessageStrip({
							text: this._getText('langInfo'),
							showIcon: true
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
				endButton: new Button({
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

		onConfigurePartnerSettingsPress: function (ctx) {
			this.getView().setBusy(true);
			if (!this._partnerSettingsDialog) {
				this._partnerSettingsDialog = sap.ui.core.Fragment.load({
					id: "idPartnerSettings",
					name: "ordermonitoring.allmyorders.fragment.PartnerSettings",
					controller: this
				}).then((dialog) => {
					return dialog;
				})
			}
			this._partnerSettingsDialog.then((dialog) => {
				this.getView().addDependent(dialog);
				let dialogModel = new JSONModel();
				dialog.setModel(dialogModel, "PartnerSettingsDialogModel");
				// Get the partner settings for the current user and store it in the model
				let mainModel = this.getView().getModel();
				let userID = this.getView().getModel('localModel').getProperty("/CurrentUser");
				let userFilter = new Filter({
					path: 'BASF_USER',
					operator: FilterOperator.EQ,
					value1: userID
				})
				mainModel.read('/PartnerSettings', {
					filters: [userFilter],
					success: (response) => {
						dialog.getModel("PartnerSettingsDialogModel").setProperty("/Partners", response.results);
						dialog.getModel("PartnerSettingsDialogModel").setProperty("/ActiveUser", this.getView().getModel('localModel').getProperty('/CurrentUser'));
						// if (response.results.length === 0) {
						// 	// Show warning message
						// 	MessageBox.warning("No partner settings maintained. Add some.");
						// }
						this.getView().setBusy(false);
						dialog.open();
					},
					error: (error) => {
						console.error(error);
						this.getView().setBusy(false);
						MessageBox.error("An error occurred. Contact support");
					}
				})

			})




		},
		onPartnerSettingAdd: function (ctx) {
			if (!this._addPartnerSettingDialog) {
				this._addPartnerSettingDialog = sap.ui.core.Fragment.load({
					id: "idAddPartnerSetting",
					name: "ordermonitoring.allmyorders.fragment.AddPartnerSetting",
					controller: this
				}).then((dialog) => {
					return dialog;
				})
			}

			this._addPartnerSettingDialog.then((dialog) => {
				this.getView().addDependent(dialog);
				dialog.setModel(new JSONModel(), 'NewPartnerSetting');
				dialog.getModel('NewPartnerSetting').setProperty('/SettingActive', true);
				dialog.open();
			})

		},

		onSaveNewPartnerSettingPress: function (ctx) {
			let mainModel = this.getView().getModel();
			let newPartnerSettingModel = ctx.getSource().getModel('NewPartnerSetting');
			var newPartnerSetting = {
				CLIENT: '100',
				BASF_USER: this.getView().getModel('localModel').getProperty('/CurrentUser'),
				PARTNER_ROLE: newPartnerSettingModel.getProperty('/PartnerRole'),
				PARTNER_NUMBER: newPartnerSettingModel.getProperty('/PartnerNumber'),
				ACTIVE: (newPartnerSettingModel.getProperty('/SettingActive') ? 'X' : ''),
				COMMT: newPartnerSettingModel.getProperty('/Comment')
			}
			this.getView().setModel(new JSONModel(), 'PartnerSettingsModel');
			this.getView().getModel('PartnerSettingsModel').setProperty('/NewPartnerSetting', newPartnerSetting);


			this._addPartnerSettingDialog.then((dialog) => {
				dialog.setBusy(true);
			})
			mainModel.create('/PartnerSettings', newPartnerSetting, {
				success: (response) => {
					this._addPartnerSettingDialog.then((dialog) => {
						dialog.setBusy(false);
						dialog.close();
					})

					this._partnerSettingsDialog.then((dialog) => {
						let addedPartnerSetting = this.getView().getModel('PartnerSettingsModel').getProperty('/NewPartnerSetting');
						dialog.getModel('PartnerSettingsDialogModel').getProperty('/Partners').push(addedPartnerSetting);
						dialog.getModel('PartnerSettingsDialogModel').refresh();
					})

				},

				error: (error) => {
					this.getView().setBusy(false);

				}
			})


		},

		onPartnerSettingDelete: function (ctx) {
			sap.ui.core.Fragment.byId("idPartnerSettings", "idPartnerSettings").getModel('PartnerSettingsDialogModel').setProperty('/IsBusy', true);
			let mainModel = this.getView().getModel();
			let selected = sap.ui.core.Fragment.byId("idPartnerSettings", "idPartnerSettingsTable").getSelectedIndices();
			let partnerSettingEntries = sap.ui.core.Fragment.byId("idPartnerSettings", "idPartnerSettings").getModel('PartnerSettingsDialogModel').getProperty('/Partners');
			let deleteEntries = []
			for (let index of selected) {
				deleteEntries.push(partnerSettingEntries[index]);
				delete partnerSettingEntries[index];
			}

			for (let entry of deleteEntries) {
				let entryKey = {
					CLIENT: '100',
					BASF_USER: this.getView().getModel('localModel').getProperty('/CurrentUser'),
					PARTNER_ROLE: entry.PARTNER_ROLE,
					PARTNER_NUMBER: entry.PARTNER_NUMBER
				};
				let deleteKey = mainModel.createKey('/PartnerSettings', entryKey)
				mainModel.remove(deleteKey, {
					success: (res) => {
						sap.ui.core.Fragment.byId("idPartnerSettings", "idPartnerSettings").getModel('PartnerSettingsDialogModel').setProperty('/Partners', partnerSettingEntries.filter((entry) => entry));
						sap.ui.core.Fragment.byId("idPartnerSettings", "idPartnerSettings").getModel('PartnerSettingsDialogModel').refresh();
						sap.ui.core.Fragment.byId("idPartnerSettings", "idPartnerSettings").getModel('PartnerSettingsDialogModel').setProperty('/IsBusy', false);
					},

					error: (res) => {
						MessageBox.error("An error occurred. Contact support.");
						sap.ui.core.Fragment.byId("idPartnerSettings", "idPartnerSettings").getModel('PartnerSettingsDialogModel').setProperty('/IsBusy', false);
					}
				})

			}
		},

		onPartnerActiveStateChanged: function (ctx) {
			let partnerActive = (ctx.getSource().getState() ? 'X' : '');
			let stateChangedEntry = ctx.getSource().getModel('PartnerSettingsDialogModel').getProperty(ctx.getSource().getBindingContext('PartnerSettingsDialogModel').getPath());
			stateChangedEntry.ACTIVE = partnerActive;
			ctx.getSource().getModel('PartnerSettingsDialogModel').refresh();




		},

		onConfirmPartnerSettings: function (ctx) {
			sap.ui.core.Fragment.byId("idPartnerSettings", "idPartnerSettings").getModel('PartnerSettingsDialogModel').setProperty('/IsBusy', true);
			// Batch update for all entries
			let mainModel = this.getView().getModel();
			let updatedEntries = sap.ui.core.Fragment.byId("idPartnerSettings", "idPartnerSettings").getModel('PartnerSettingsDialogModel').getProperty('/Partners');
			// Only send update if there are entries to update
			if (updatedEntries.length !== 0) {
				for (let entry in updatedEntries) {
					let entryKey = mainModel.createKey('/PartnerSettings', {
						CLIENT: updatedEntries[entry].CLIENT,
						BASF_USER: updatedEntries[entry].BASF_USER,
						PARTNER_ROLE: updatedEntries[entry].PARTNER_ROLE,
						PARTNER_NUMBER: updatedEntries[entry].PARTNER_NUMBER
					})

					let entryValue = {
						ACTIVE: updatedEntries[entry].ACTIVE,
						COMMT: updatedEntries[entry].COMMT
					}

					mainModel.update(entryKey, entryValue, {
						success: (res) => {
							sap.ui.core.Fragment.byId("idPartnerSettings", "idPartnerSettings").getModel('PartnerSettingsDialogModel').setProperty('/IsBusy', false);
							this.getView().byId('idSmartTable').rebindTable();
							this._partnerSettingsDialog.then((dialog) => {
								dialog.close();
							});
						},

						error: (res) => {
							sap.ui.core.Fragment.byId("idPartnerSettings", "idPartnerSettings").getModel('PartnerSettingsDialogModel').setProperty('/IsBusy', false);
							MessageBox.error("An error occurred. Contact support");
						}
					})

				}

			}



		},

		onCancelPartnerSettings: function (ctx) {
			this._partnerSettingsDialog.then((dialog) => {
				dialog.close();
			})
		},

		onCancelNewPartnerSettingPress: function (ctx) {
			this._addPartnerSettingDialog.then((dialog) => {
				dialog.close();
			})
		},



		// onPartnerSettingsChangeUserPress: function (ctx) {
		// 	// 
		// 	// return;
		// 	if (!this._activeUsersSelectDialog) {
		// 		this._activeUsersSelectDialog = sap.ui.core.Fragment.load({
		// 			id: "idActiveUsersSelect",
		// 			name: "ordermonitoring.allmyorders.fragment.ActiveUsers",
		// 			controller: this
		// 		}).then((dialog) => {
		// 			return dialog;
		// 		})
		// 	}

		// 	this._activeUsersSelectDialog.then((dialog) => {
		// 		this.getView().addDependent(dialog);
		// 		let activeUsers = this.getView().getModel("PartnerSettingsModel").getProperty("/ActiveUsers");
		// 		let model = new JSONModel();
		// 		dialog.setModel(model, 'ActiveUsersDialogModel');
		// 		dialog.getModel('ActiveUsersDialogModel').setProperty('/ActiveUsers', activeUsers);
		// 		dialog.open();

		// 	})

		// },

		// onActiveUserSelected: function (ctx) {
		// },


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
			this._navToNotes(salesOrder, orderItem)

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
					// added because the list is refreshed.. and that might change the index of the previously selected row.. 
					this.getView().byId('idSmartTable').getTable().setSelectedIndex(-1)
					this.getView().getModel('localModel').setProperty('/salesOrderTable', []);
					// added because the list is refreshed.. and that might change the index of the previously selected row.. 
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
		_navToNotes: function (salesOrder, orderItem) {
			this.oRouter.navTo("notes", { salesOrder: salesOrder, orderItem: orderItem });
		}
	});
});