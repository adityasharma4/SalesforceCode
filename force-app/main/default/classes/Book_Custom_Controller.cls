public class Book_Custom_Controller {

    //data member / property / attribute
    //sobject == Salesforce object
    /* */
    private Book__C book;

    private List<Book__C> books;
    private final integer MAX_RECORDS_PER_PAGE = 5;

    public integer startingFrom { get; set; }
    private integer bookRecordCount;

    private class BookCopiesWrapper {
        public integer bookCopyUnIssuedQty { get; set; }
        public Id bookRecordId { get; set; }
    }

    private class BorrowerTrendWrapper {
        public integer borrowerCount { get; set; }
        public Id bookRecordId { get; set; }
    }

    public BookCopiesWrapper bookCopiesWrapper { get; set; }
    public BorrowerTrendWrapper borrowerTrendWrapper { get; set; }

    public Book_Custom_Controller() {
        Id bookRecordId;
        bookRecordId = ApexPages.currentPage().getParameters().get('id');

        if(startingFrom == null) startingFrom = 0;
        if(bookRecordId == null) book = new Book__C();      //empty instance of Book__c SObject 
        else {
            book = [SELECT Name, Genre__C, Quantity__C,Description__c,number_of_authors__C 
                    FROM Book__C
                    WHERE Id = :bookRecordId];
        }

        bookRecordCount = [SELECT COUNT() FROM Book__c];
        bookCopiesWrapper = new BookCopiesWrapper();
        borrowerTrendWrapper = new BorrowerTrendWrapper();
    }

    public List<Book__C> getBooks() {
        books = [SELECT Name, Genre__C, Quantity__C,number_of_authors__C 
                FROM Book__C
                ORDER By Name
                LIMIT :MAX_RECORDS_PER_PAGE
                OFFSET :startingFrom];

        return books;
    }

    public Book__C getBook() { return this.book; }
    public void setBook(Book__C book) { this.book = book; }

    public Pagereference save() {
        try {
            //apex dml
            upsert book;
        } catch(DmlException ex) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,ex.getMessage()));
            return ApexPages.currentPage();
        }
        Pagereference pg;
        pg = new ApexPages.StandardController(book).view();
        return pg;
    }

    public Pagereference previous() {
        if(startingFrom <= 0)
            startingFrom = 0;
        else if(startingFrom >= bookRecordCount)
            startingFrom = startingFrom - MAX_RECORDS_PER_PAGE;
        else if(startingFrom < bookRecordCount)
            startingFrom = startingFrom - MAX_RECORDS_PER_PAGE;        

        return Apexpages.currentPage();
    } 

    public Pagereference next() {
        if((bookRecordCount - startingFrom) > MAX_RECORDS_PER_PAGE)
            startingFrom = startingFrom + MAX_RECORDS_PER_PAGE;
        return Apexpages.currentPage();
    }

    public void unIssuedBookCount() {
        bookCopiesWrapper.bookCopyUnIssuedQty = [SELECT COUNT() FROM Book_Copy__C
                                                WHERE Book__C = :bookCopiesWrapper.bookRecordId
                                                AND Issued__c = false];
    }

    public void borrowerTrend() {
        Date today = System.date.today();
        Date lastYearDate = today.addYears(-1);

        borrowerTrendWrapper.borrowerCount = [SELECT COUNT() FROM Borrower__c
                                              WHERE Book_Copy__r.Book__C = :borrowerTrendWrapper.bookRecordId
                                              AND (Issued_on__C <= :today AND Issued_on__C >= :lastYearDate)];

    }
}