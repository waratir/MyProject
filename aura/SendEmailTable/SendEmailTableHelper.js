({
    getObjectRecords: function (component, helper) {
        let action = component.get('c.getSendEmailControll');

        action.setCallback(this, $A.getCallback(function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.totalPages', Math.ceil(response.getReturnValue().length / component.get("v.pageSize")));
                component.set("v.allData", response.getReturnValue());
                component.set("v.currentPageNumber", 1);
                helper.buildData(component, helper);
            } else if (state === "ERROR") {
                alert("WARNING!!!! This select has errors");
            }
        }));
        $A.enqueueAction(action);

    },

    sortData: function (cmp, fieldName, sortDirection) {
        let data = cmp.get("v.data");
        let reverse = sortDirection !== 'asc';

        data = Object.assign([],
            data.sort(this.sortBy(fieldName, reverse ? -1 : 1))
        );
        cmp.set("v.data", data);
    },

    sortBy: function (field, reverse, primer) {
        let  key = primer
            ? function (x) {
                return primer(x[field]);
            }
            : function (x) {
                return x[field];
            };

        return function (a, b) {
            let A = key(a);
            let B = key(b);
            return reverse * ((A > B) - (B > A));
        };
    },

    buildData: function (component, helper) {
        let data = [];
        let pageNumber = component.get("v.currentPageNumber");
        let pageSize = component.get("v.pageSize");
        let allData = component.get("v.allData");
        let x = (pageNumber - 1) * pageSize;

        for (; x <= (pageNumber) * pageSize; x++) {
            if (allData[x]) {
                data.push(allData[x]);
            }
        }
        component.set("v.data", data);
        helper.generatePageList(component, pageNumber);
    },

    generatePageList: function (component, pageNumber) {
        pageNumber = parseInt(pageNumber);
        let pageList = [];
        let totalPages = component.get("v.totalPages");
        if (totalPages > 1) {
            if (totalPages <= 10) {
                let counter = 2;
                for (; counter < (totalPages); counter++) {
                    pageList.push(counter);
                }
            } else {
                if (pageNumber < 5) {
                    pageList.push(2, 3, 4, 5, 6);
                } else {
                    if (pageNumber > (totalPages - 5)) {
                        pageList.push(totalPages - 5, totalPages - 4, totalPages - 3, totalPages - 2, totalPages - 1);
                    } else {
                        pageList.push(pageNumber - 2, pageNumber - 1, pageNumber, pageNumber + 1, pageNumber + 2);
                    }
                }
            }
        }
        component.set("v.pageList", pageList);
    },
});