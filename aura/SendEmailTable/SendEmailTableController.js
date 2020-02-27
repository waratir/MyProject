({
    init: function (component, event, helper) {
        let columns = [];
        columns.push(
            {label: 'Object Name', fieldName: 'Object_Name__c', sortable: true},
            {label: 'Data field', fieldName: 'Data_field__c', sortable: true},
            {label: 'Criteria', fieldName: 'Criterion__c', sortable: true},
            {label: 'Email Template', fieldName: 'Email_Template_Name__c', sortable: true},
            {
                type: 'button',
                cellAttributes: {alignment: 'right'},
                typeAttributes:
                    {
                        label: 'Preview',
                        name: 'previewRecords',
                        title: 'previewTittle',
                        disabled: false,
                        value: 'test'
                    }
            }
        );
        component.set('v.columns', columns);
        helper.getObjectRecords(component, helper);
    },

    refreshTable: function (component, event, helper) {
        helper.getObjectRecords(component, helper);
    },

    updateColumnSorting: function (cmp, event, helper) {
        let fieldName = event.getParam('fieldName');
        let sortDirection = event.getParam('sortDirection');

        cmp.set("v.sortedBy", fieldName);
        cmp.set("v.sortedDirection", sortDirection);
        helper.sortData(cmp, fieldName, sortDirection);
    },

    onNext: function (component, event, helper) {
        let pageNumber = component.get("v.currentPageNumber");

        component.set("v.currentPageNumber", pageNumber + 1);
        helper.buildData(component, helper);
    },

    onPrev: function (component, event, helper) {
        let pageNumber = component.get("v.currentPageNumber");

        component.set("v.currentPageNumber", pageNumber - 1);
        helper.buildData(component, helper);
    },

    processMe: function (component, event, helper) {
        component.set("v.currentPageNumber", parseInt(event.target.name));
        helper.buildData(component, helper);
    },

    onFirst: function (component, event, helper) {
        component.set("v.currentPageNumber", 1);
        helper.buildData(component, helper);
    },

    onLast: function (component, event, helper) {
        component.set("v.currentPageNumber", component.get("v.totalPages"));
        helper.buildData(component, helper);
    },

    previewRecord: function (component, event, helper) {
        component.set("v.isOpen", true);
        let action = event.getParam('action');
        let row = event.getParam('row');
        if (action.name === 'previewRecords') {
            helper.getRecordForPreview(component, row);
        }
    },

});