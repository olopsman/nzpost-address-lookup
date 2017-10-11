({
  afterRender : function(component, helper) {
    this.superAfterRender();
    var streetInputCmp = component.find("street-search");
    //console.log(streetInputCmp);
    var streetInput = streetInputCmp.getElement();
    var streetListType = 'street-list-' + component.get('v.streetType');
    streetInput.setAttribute("list",streetListType);
  }
})