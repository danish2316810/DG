sap.ui.define([
    "sap/ui/core/mvc/ControllerExtension",
    "sap/ui/core/Fragment",
    "sap/m/MessageBox",
    "../utils/constants"
], function (ControllerExtension, Fragment, MessageBox,constants) {
    'use strict';

    return ControllerExtension.extend("dgdispodm.ext.controller.ListReport", {
        override : {
            onAfterRendering : function(){  //initializing the values
                this.localModel = this.getView().getModel('localModel');
                this.i18nModel = this.getView().getModel('i18n');
                this.localModel.setProperty('/componentIds',{
                    "listRepo" : 'dgdispodm::DecisionMatrixSetList--fe::ListReport',
                    "gridTable" : 'dgdispodm::DecisionMatrixSetList--fe::table::DecisionMatrixSet::LineItem-innerTable'
                })
                this.localModel.setProperty('/yesno',constants['yes-no']);
                this.localModel.setProperty('/scanReq',constants['req-nonreq']);
                
                this.getView().byId(this.localModel.getProperty('/componentIds').listRepo).getAggregation('title').removeAllActions();
                this.getView().byId(this.localModel.getProperty('/componentIds').listRepo).getContent().getContent().addEventDelegate({
                    onAfterRendering : function(oEvent){
                        this.getView().byId(this.localModel.getProperty('/componentIds').gridTable).setFixedColumnCount(3);
                        this.getView().byId(this.localModel.getProperty('/componentIds').gridTable)._oSelectionPlugin.setSelectionMode('Single')
                    }.bind(this)
                })
            }
        },
        
        openDialog: async function () { //to open the fragment
            if (!this.createDialog) {
                let odialog = await Fragment.load({
                    type: "XML",
                    controller: this,
                    name: "dgdispodm.ext.fragment.create"
                });
                this.createDialog = odialog;
                this.getView().addDependent(odialog);
                this.createDialog.open();
            }
            else {
                this.createDialog.open();
            };

            if (this.operation == 'edit') {
                this.createDialog.setContentWidth('50rem');
                sap.ui.getCore().byId('idAddBtn').setEnabled(false);
                sap.ui.getCore().byId('idUiTable').setVisibleRowCount(1);
                sap.ui.getCore().byId('idUiTable').setSelectionMode('None');
            }
            else {
                this.createDialog.setContentWidth('');
                sap.ui.getCore().byId('idUiTable').setVisibleRowCount(2);
                sap.ui.getCore().byId('idUiTable').setSelectionMode('MultiToggle');
                sap.ui.getCore().byId('idAddBtn').setEnabled(true);
                this.initializeDataInModel();
            }
            this.localModel.refresh(true);
        },
        onEdit: async function (oEvent) {   //will be triggered when edit button clicked 
            let aEditContexts = this.getView().byId(this.localModel.getProperty('/componentIds').gridTable)._getSelectionPlugin().getSelectedContexts();
            if (aEditContexts.length == 0) {
                MessageBox.error(this.i18nModel.getProperty('rowSelectErr'));
                return;
            }
            let aEdit = [];
            aEditContexts.forEach((context, index) => {
                let obj = context.getObject();
                obj['path'] = context.getPath();
                obj['id'] = index;
                aEdit.push(obj);
            });
            this.localModel.setProperty('/createData', aEdit);
            this.localModel.setProperty('/editMode', {    //for edit mode , column visiblilty in dialog
                "reclamation" : false,
                "matLeak" : false,
                "matHaz" : false
            });
            this.localModel.refresh(true);
            this.operation = 'edit';
            this.openDialog();
        },
        oncreatecancel: function (oEvent) { //will trigger after hitter cancel button in dialog
            oEvent.getSource().getParent().close();
            this.localModel.setProperty('/createData', []);
        },
        oncreatesave: async function (oEvent) {  //will trigger after hitting save button in dialog
            let aSelectedIndex = sap.ui.getCore().byId('idUiTable').getSelectedIndices();
            
            if (this.operation == 'create') {
                if (aSelectedIndex.length == 0) {
                    MessageBox.error(this.i18nModel.getProperty('rowSelectErr'));
                    return;
                }
                this.resultOfCreate=undefined;
                let DecisionMatrixSet = await this.getView().getModel().bindList("/DecisionMatrixSet", { $$updateGroupId: "updgrp" });
                for (let indx of aSelectedIndex) {
                    //for create operation
                    let data = this.localModel.getProperty('/createData')[indx];
                    delete data['id'];
                    await DecisionMatrixSet.create(data);
                    this.getView().setBusy(true);
                }

                DecisionMatrixSet.attachCreateCompleted(function (event) {
                    this.getView().setBusy(false);
                    if (!this.resultOfCreate) {
                        this.resultOfCreate = true;
                        if (event.getParameter('success')) {
                            MessageBox.success(this.i18nModel.getProperty('saveSuccess'));
                            this.localModel.setProperty('/createData', []);
                            this.localModel.refresh(true);
                            this.getView().byId(this.localModel.getProperty('/componentIds').gridTable).getBinding('rows').refresh();
                            this.createDialog.close();
                        }
                        else {
                            MessageBox.error(event.getParameter('context').getModel().getMessagesByPath('')[0].message);
                        }
                    }
                }.bind(this));
            }
            else {  //for update operation
                    let data = sap.ui.getCore().byId('idUiTable').getRows()[0].getBindingContext('localModel').getObject();
                    let DecisionMatrixSet = await this.getView().getModel().bindContext(data['path'], undefined, { $$updateGroupId: "myUpdateGroup" });
                    for (let key of Object.keys(data)) {
                        if (key !== 'path') {
                            try {
                                DecisionMatrixSet.getBoundContext().setProperty(key, data[key])
                            }
                            catch (err) {
                                MessageBox.error(err.message);
                                return;
                            }
                        }

                    }

                //batch call for update operation
                this.getView().getModel().submitBatch('myUpdateGroup').then(data => {
                    MessageBox.success(this.i18nModel.getProperty('saveSuccess'));
                    this.localModel.setProperty('/createData', []);
                    this.localModel.refresh(true);
                    this.getView().byId(this.localModel.getProperty('/componentIds').gridTable).getBinding('rows').refresh();
                    this.createDialog.close();
                }).catch(err => {
                    MessageBox.error(err.message);
                });
            }
        },
        onRowDelete: function (oEvent) {   //will trigger when delete button will be clicked on the dialog table
            let aSelectedIndex = sap.ui.getCore().byId('idUiTable').getSelectedIndices();
            aSelectedIndex.forEach((indx) => {
                let indxToRemove = this.localModel.getProperty('/createData').findIndex(data => data.id == indx);
                this.localModel.getProperty('/createData').splice(indxToRemove, 1)
            });
            this.localModel.refresh(true);
        },
        onRowAdd: function (oEvent) {  //to add the rows in the dialog table
            this.initializeDataInModel();
        },
        onCreate: function (oEvent) { //will triger after clicking on create button
            this.localModel.setProperty('/editMode', {    //for edit mode , column visiblilty in dialog
                "reclamation" : true,
                "matLeak" : true,
                "matHaz" : true
            });
            this.localModel.refresh(true);
            this.operation = 'create';
            this.openDialog();
        },
        initializeDataInModel: function () {  //to refresh the data in model

            if (this.localModel.getProperty('/createData')) {
                this.localModel.getProperty('/createData').push({
                    "id": this.localModel.getProperty('/createData').length,
                    "MaterialIsReclam": "",
                    "MaterialIsLeak": "",
                    "MaterialIsHaz": "",
                    "HazType": "",
                    "Container": "",
                    "IsContainerRequired": ""
                });
            }
            else {
                this.localModel.setProperty('/createData', [{
                    "id": 0,
                    "MaterialIsReclam": "",
                    "MaterialIsLeak": "",
                    "MaterialIsHaz": "",
                    "HazType": "",
                    "Container": "",
                    "IsContainerRequired": ""
                }]);
            }
            this.localModel.refresh(true);
        }
    });
});
