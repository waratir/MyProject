({
    init: function (component, event, helper) {
        helper.getObjectAndTemplatesNames(component);
    },

    showFieldsPickList: function (component, event, helper) {
        helper.getFieldsNames(component);
    },

    closeModel: function (component, event, helper) {
        component.set("v.isOpen", false);
    },

    saveModel: function (component, event, helper) {
        helper.saveDataToBase(component);
    },

    showDetailTemplate: function (component, event, helper) {
        let templates = component.get('v.templateNames');

        let filtr = templates.filter(function (e) {
            return e.Name === component.get('v.selectTemplate');
        });

        component.set('v.findTemplate', filtr[0]);
        component.set("v.isOpenDetail", true);
    }
});