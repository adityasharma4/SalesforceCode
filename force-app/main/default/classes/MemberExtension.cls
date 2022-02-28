public with sharing class MemberExtension {

    public Member__C member { get; set; }

    private ApexPages.StandardController stdController;

    public MemberExtension() {

    }
    public MemberExtension(ApexPages.StandardSetController stdSetController) {

    }
    public MemberExtension(ApexPages.StandardController stdController) {

        this.stdController = stdController;

        List<String> fieldNames = new List<String>();
        fieldNames.add('Name');
        fieldNames.add('joined_on__C');
        fieldNames.add('email__c');
        fieldNames.add('active__c');

        stdController.addFields(fieldNames);

        member = (Member__c) stdController.getRecord();
    }

    public Pagereference save() {
        try {
            system.debug('---------> Save method of extension called !');
            update member;
        } catch(DmlException ex) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.FATAL, 
                                ex.getMessage()));
            return ApexPages.currentPage();
        }

        return stdController.view();
    }
}
