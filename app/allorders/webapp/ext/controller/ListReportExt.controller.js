sap.ui.define(["sap/ui/core/mvc/ControllerExtension", "sap/m/MessageBox","sap/m/Dialog","sap/m/VBox","sap/m/TextArea","sap/m/CheckBox","sap/m/Button"], function (ControllerExtension, MessageToast,Dialog,VBox,TextArea, CheckBox,Button) {
        "use strict";
        
        return ControllerExtension.extend("ordermonitoring.allorders.ext.controller.ListReportExt", {
            
            onAddNewNote: function (oContext, aSelectedContexts) {
                let oDialog = new Dialog({
                    title: 'add new note',
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
                                text: 'onHeaderLevel'
                            })
                        ]
                    }),
                    beginButton: new Button({
                        text: 'add Comment',
                        enabled: true,
                        press: [function () {
                            var sNewNote = oDialog.getContent()[0].getItems()[0].getValue().trim();
                            var bOnHeader = oDialog.getContent()[0].getItems()[1].getSelected();
                            this._onAddComment(aSelectedContexts[0].getObject().SalesOrder,sNewNote);
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
            _onAddComment: function(salesOrder,sNewNote){
                var sTitle = "Sales Order " + salesOrder;
                let creatItem = {
					SalesOrderID: salesOrder,
                    
					/*SalesOrderID: "3000000134",*/
					Title: sTitle,
					/*Title: "&CSEU& Sales Order " + "3000000134", */
					Content: sNewNote
				};
                let oModel = this.getView().getModel("notesModel");
                oModel.create('/NoteSet', creatItem,{
                    success: (()=>{debugger;}),
                    error: (()=>{debugger;})
                })
                
                
            },
            override: {
                routing: {
                    onAfterBinding: function () {
                        
                    }
                },
                onAfterRendering: async function () {
                    
                },
                onBeforeRendering: function () {
                    
                },
                onInit: async function () {
                    
            }
        }})
    });
