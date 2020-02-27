({
    getObjectAndTemplatesNames: function (component, event, helper) {
        let action1 = component.get('c.getObjectNames');
        action1.setCallback(this, $A.getCallback(function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let sortField = response.getReturnValue();
                component.set('v.objectNames', sortField.sort());
            } else if (state === "ERROR") {
                alert("WARNING!!!! Check Object");
            }
        }));
        $A.enqueueAction(action1);

        let action2 = component.get('c.TemplatesNames');
        action2.setCallback(this, $A.getCallback(function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.templateNames', response.getReturnValue());
                let temp = component.get('v.templateNames');
                temp.push({Name: ' ', Body: ' ', selected: true});
                component.set('v.templateNames', temp);
            } else if (state === "ERROR") {
                alert("WARNING!!!! Check Template");
            }
        }));
        $A.enqueueAction(action2);
    },

    getFieldsNames: function (component, event, helper) {
        let action = component.get('c.getFieldNames');
        action.setParams({selectedObject: component.get('v.selectObject')});
        action.setCallback(this, $A.getCallback(function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let sortField = response.getReturnValue();
                sortField.sort(function (a, b) {
                    if (a.label > b.label) {
                        return 1;
                    }
                    if (a.label < b.label) {
                        return -1;
                    }
                    return 0;
                });
                component.set('v.fieldNames', sortField);

            } else if (state === "ERROR") {
                alert("WARNING!!!! Check Fields");
            }
        }));
        $A.enqueueAction(action);
    },

    // sortFunction: function (sortItem) {
    //     console.log(sortItem);
    //     let sortOption = sortItem;
    //     sortOption.sort(function (a, b) {
    //         if (a.Name > b.Name) {
    //             return 1;
    //         }
    //         if (a.Name < b.Name) {
    //             return -1;
    //         }
    //         return 0;
    //     });
    //     console.log(sortOption);
    //     return sortOption;
    // }
});