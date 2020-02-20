({
    showHideSentEmailTable: function (component, event, helper) {
        component.set('v.showHideTable', component.get('v.showHideTable') !== true);
    },

    openPopup: function (component, event, helper) {
        component.set("v.isOpen", true);
    }
});