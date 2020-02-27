({
    closeModel: function(component, event, helper) {
        component.set("v.isOpen", false);
        console.log('templsfd ' + component.get('v.template'));
    },
});