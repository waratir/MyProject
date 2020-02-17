({
    showHideSentEmailTable: function (component, event, helper) {
        if (component.get('v.showHideTable')) {
            component.set('v.showHideTable', false);
        } else {
            component.set('v.showHideTable', true);
        }
    },

    openPopup: function (component, event, helper) {
        component.set("v.isOpen", true);
    }
});