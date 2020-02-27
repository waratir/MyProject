({
    init: function (component, event, helper) {
        let columns = [];
        columns.push(
            {label: 'First Name', fieldName: 'FirstName', sortable: true},
            {label: 'Last Name', fieldName: 'LastName', sortable: true}
        );
        component.set('v.columns', columns);
    },

    closeModel: function (component, event, helper) {
        component.set("v.isOpen", false);
    },
});