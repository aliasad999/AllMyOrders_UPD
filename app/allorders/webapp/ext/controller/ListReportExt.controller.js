sap.ui.define(["sap/ui/core/mvc/ControllerExtension", "sap/m/MessageBox"], function (ControllerExtension, MessageToast) {
        "use strict";
        
        return ControllerExtension.extend("ordermonitoring.allorders.ext.controller.ListReportExt", {
            
            onAddNewNote: function (oContext, aSelectedContexts) {
                debugger;
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
                    debugger;
            }
        }})
    });
