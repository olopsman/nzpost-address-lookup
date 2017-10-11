({
	fieldChange : function(component, event, helper) {
		 helper.checkNZPost(component);
	},
	//fires onblur - get the dpID, else just get the field value
	checkSelected : function(component, event, helper) {
		helper.checkSelectedCall(component, event, helper);
	}

})