({
    getObjectAndTemplatesNames: function (component, event, helper) {
        let action1 = component.get('c.getObjectNames');
        action1.setCallback(this, $A.getCallback(function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let objects = response.getReturnValue();
                component.set('v.objectNames', objects.sort(this.sortFunction('label')));
            } else if (state === "ERROR") {
                let errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        this.showToast(errors[0].message)
                    }
                } else {
                    this.showToast('Unknown error')
                }
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
                component.set('v.templateNames', temp.sort(this.sortFunction('Name')));
            } else if (state === "ERROR") {
                let errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        this.showToast(errors[0].message)
                    }
                } else {
                    this.showToast('Unknown error')
                }
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
                component.set('v.fieldNames', sortField.sort(this.sortFunction('label')));
            } else if (state === "ERROR") {
                let errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        this.showToast(errors[0].message)
                    }
                } else {
                    this.showToast('Unknown error')
                }
            }
        }));
        $A.enqueueAction(action);
    },

    saveDataToBase: function (component, event, helper) {
        let action = component.get('c.saveData');
        action.setParams(
            {
                selectedObject: component.get('v.selectObject'),
                selectField: component.get('v.selectField'),
                selectCriterion: component.get('v.selectCriterion'),
                selectTemplate: component.get('v.selectTemplate')
            }
        );
        action.setCallback(this, $A.getCallback(function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.isOpen", false);
                component.set('v.selectObject', '');
                component.set('v.selectField', '');
                component.set('v.selectCriterion', '');
                component.set('v.selectTemplate', '');
                let appEvent = $A.get("e.c:SendEmailRefreshTableEvent");
                appEvent.fire();
            } else if (state === "ERROR") {
                let errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        this.showToast(errors[0].message)
                    }
                } else {
                    this.showToast('Unknown error')
                }
            }
        }));
        $A.enqueueAction(action);

    },

    sortFunction: function (key) {
        let order = 'asc';
        return function innerSort(a, b) {
            if (!a.hasOwnProperty(key) || !b.hasOwnProperty(key)) {
                return 0;
            }
            const varA = (typeof a[key] === 'string')
                ? a[key].toUpperCase() : a[key];
            const varB = (typeof b[key] === 'string')
                ? b[key].toUpperCase() : b[key];

            let comparison = 0;
            if (varA > varB) {
                comparison = 1;
            } else if (varA < varB) {
                comparison = -1;
            }
            return (
                (order === 'desc') ? (comparison * -1) : comparison
            );
        };
    },

    showToast : function(errorMessage) {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": errorMessage
        });
        toastEvent.fire();
    }

});