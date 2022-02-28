// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

boolean blnVal;
integer iVal;
double dblVal;
Long lngVal;
String str;
Id recId;
Date dt;
Time tm;
Datetime dtTm;

blnVal = true;
iVal = 1100;
dblVal = 74.346;
lngVal = 234324;
str = 'Today is Tuesday!';
dt = system.Date.newInstance(2022, 1, 5);
tm = System.Time.newInstance(18, 5, 10, 0);
dtTm = System.datetime.newInstance(dt, tm);

system.debug(blnVal);
system.debug(dblVal);
system.debug(dt);
system.debug(tm);

integer x = 10, y = 20;

if(x > 10 && y <= 50) {

} else {

}

for(x = 1 ; x <= 10 ; x++) {
    system.debug(x);
}

while(y > 50) {
    y--;
}

do {
    x++;
} while(x < 20);

//integer, long, sobject, string, enum
switch on iVal {
    when 10 { }
    when 20,30,40 { }
    when else { }
}

Season s;
s = Season.SUMMER;
System.debug(s);

Shape sh;

sh = new Shape();
sh.calculateArea();

sh = new Triangle();
sh.calculateArea();

List<Book__C> lst = new List<Book__C>();

lst.add(new Book__C(Name='Book-01',Quantity__C=5));
lst.add(new Book__C(Name='Book-02',Quantity__C=1));
lst.add(new Book__C(Name='Book-03',Quantity__C=2));

for(Book__c c : lst) {
    system.debug('========================');
    System.debug(c.Name);
    system.debug(c.quantity__C);
}

Set<Account> accounts = new Set<Account>();

accounts.add(new Account(Name='Account-01'));
accounts.add(new Account(Name='Account-02'));
accounts.add(new Account(Name='Account-03'));

for(Account a : accounts) {
    System.debug('===============');
    System.debug(a.Name);
}

Map<Book__C, List<Book_Copy__C>> bookmap = new Map<Book__C, List<Book_Copy__C>>();

bookmap.put(new Book__C(Name='Book-01'), new List<Book_Copy__C()>());
bookmap.put(new Book__C(Name='Book-02'), new List<Book_Copy__C()>());
bookmap.put(new Book__C(Name='Book-03'), new List<Book_Copy__C()>());

for(Book__C key : bookmap.keyset()) {
    for(Book_Copy__C bkcpy : bookmap.get(key)) {
       system.debug(bkcpy.name); 
    }
}











