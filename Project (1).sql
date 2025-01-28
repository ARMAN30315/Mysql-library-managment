-- Create the database
CREATE DATABASE LM;


-- Use the database
USE LM  ; 


-- Create Members table
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    email varchar(100) unique,
    phone varchar(15) unique,
    joinDate DATE NOT NULL,
    MembershipType VARCHAR(50) NOT NULL
);

insert into members(name,email,phone, JoinDate,MembershipType)
values
('Arman', 'arman123@gmail.com',8400737121,'2024-11-01', 'Standard'),
('farman','farman123@gmail.com',8400737122,'2024-11-02', 'Premium'),
('rehan','rehan123@gmail.com',8400737123,'2024-11-03', 'Premium'),
('salman','salman123@gmail.com',8400737124,'2024-11-04', 'Standard'),
('farhan','farhan123@gmail.com',8400737125,'2024-11-05', 'Premium'),
('gulfam','gulfam123@gmail.com',8400737126,'2024-11-06', 'Premium'),
('jishan','jishan123@gmail.com',8400737127,'2024-11-07', 'Standard'),
('sameer','sameer123@gmail.com',8400737128,'2024-11-08', 'Standard'),
('osama','osama123@gmail.com',8400737129,'2024-11-09', 'Premium'),
('sajid','sajid123@gmail.com',8400737120,'2024-11-01', 'Standard');
SELECT * FROM members;



-- Create Books table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Book_name VARCHAR(200) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Genre VARCHAR(50),
    AvailableCopies INT NOT NULL
);


INSERT INTO Books (Book_name, Author, Genre, AvailableCopies) 
VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 3),
('1984', 'George Orwell', 'Dystopian', 5),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 2),
('Pride and Prejudice', 'Jane Austen', 'Romance', 4),
('The Catcher in the Rye', 'J.D. Salinger', 'Classic', 6),
('Moby Dick', 'Herman Melville', 'Adventure', 3),
('War and Peace', 'Leo Tolstoy', 'Historical Fiction', 2),
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 7),
('Brave New World', 'Aldous Huxley', 'Science Fiction', 4),
('Crime and Punishment', 'Fyodor Dostoevsky', 'Philosophical Fiction', 3);
SELECT * FROM books;


-- Create Borrowing table
CREATE TABLE Borrowing (
    BorrowID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    BorrowDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

SELECT * FROM Borrowing;

insert into Borrowing (MemberID,BookID,BorrowDate,ReturnDate)
values
(1,1,'2024-11-01',null),
(2,2,'2024-11-02','2024-11-20'),
(3,3,'2024-11-15',null),
(4,4,'2024-11-16','2024-11-20'),
(5,5,'2024-11-25','2024-11-30'),
(6,6,'2024-11-29',null),
(7,7,'2024-11-05','2024-11-11'),
(8,8,'2024-11-02',null),
(9,9,'2024-11-06','2024-11-19'),
(10,10,'2024-11-07',null);

SELECT * FROM Borrowing ; 



#1. SELECT
#Retrieve all details from the Members table.
SELECT * FROM Members;

#2. WHERE
#Find members with a MembershipType of "Premium."
SELECT * FROM Members WHERE MembershipType = 'Premium';

#3. AND
#Find books with the genre "Fiction" and more than 2 available copies.
SELECT * FROM Books WHERE Genre = 'Fiction' AND AvailableCopies > 2;

#4. OR
#Find members who joined on "2024-11-01" or have a "Standard" membership.
SELECT * FROM Members WHERE JoinDate = '2024-11-01' OR MembershipType = 'Standard';

#5. ORDER BY
#List books in ascending order by AvailableCopies.
SELECT * FROM Books ORDER BY AvailableCopies ASC;

#6. LIMIT
#Retrieve the first 5 members.
SELECT * FROM Members LIMIT 5;

#7. LIKE
#Find members whose email contains "gmail".
SELECT * FROM Members WHERE email LIKE '%gmail%';

#8. IN
#Find books belonging to genres "Fiction," "Fantasy," or "Adventure."
SELECT * FROM Books WHERE Genre IN ('Fiction', 'Fantasy', 'Adventure');


#9. NOT IN
#Find books not in the genres "Romance" or "Dystopian."
SELECT * FROM Books WHERE Genre NOT IN ('Romance', 'Dystopian');


#10. BETWEEN
#Find books with AvailableCopies between 3 and 5.
SELECT * FROM Books WHERE AvailableCopies BETWEEN 3 AND 5;

#11. IS NULL
#Find all borrowings where the book has not been returned.
SELECT * FROM Borrowing WHERE ReturnDate IS NULL;

#12. IS NOT NULL
#Find all borrowings where the book has been returned.
SELECT * FROM Borrowing WHERE ReturnDate IS NOT NULL;

#13. COUNT
#Count the number of premium members.
SELECT COUNT(*) AS PremiumMembers FROM Members WHERE MembershipType = 'Premium';

#14. SUM
#Calculate the total available copies of all books.
SELECT SUM(AvailableCopies) AS TotalCopies FROM Books;


#15. AVG
#Calculate the average number of available copies across books.
SELECT AVG(AvailableCopies) AS AverageCopies FROM Books;

#16. GROUP BY
#Group borrowings by MemberID and count the number of borrowings per member.
SELECT MemberID, COUNT(*) AS BorrowCount FROM Borrowing GROUP BY MemberID;

#17. HAVING
#Find members who borrowed more than 1 book.
SELECT MemberID, COUNT(*) AS BorrowCount 
FROM Borrowing 
GROUP BY MemberID 
HAVING BorrowCount > 1;

#18. INNER JOIN
#List all borrowings along with the member name and book title.
SELECT Borrowing.BorrowID, Members.Name, Books.Book_name, Borrowing.BorrowDate, Borrowing.ReturnDate 
FROM Borrowing 
INNER JOIN Members ON Borrowing.MemberID = Members.MemberID 
INNER JOIN Books ON Borrowing.BookID = Books.BookID;

#19. LEFT JOIN
#List all members and their borrowing details (if any).
SELECT Members.Name, Borrowing.BorrowID, Borrowing.BorrowDate 
FROM Members 
LEFT JOIN Borrowing ON Members.MemberID = Borrowing.MemberID;

#20. UPDATE
#Update the AvailableCopies of a book after it has been borrowed.
UPDATE Books SET AvailableCopies = AvailableCopies - 1 WHERE BookID = 1;
select * from books;


#21. Combine Premium and Standard Members
#Retrieve the names of all members, labeled by their membership type.
SELECT Name AS MemberName, 'Premium' AS MembershipCategory
FROM Members
WHERE MembershipType = 'Premium'
UNION
SELECT Name AS MemberName, 'Standard' AS MembershipCategory
FROM Members
WHERE MembershipType = 'Standard';


#22. Combine Borrowing Dates for Borrowed and Returned Books
#Retrieve a list of books that are currently borrowed and those returned, along with their borrow dates.
SELECT Books.Book_name AS BookTitle, Borrowing.BorrowDate, 'Borrowed' AS Status
FROM Borrowing
JOIN Books ON Borrowing.BookID = Books.BookID
WHERE Borrowing.ReturnDate IS NULL
UNION
SELECT Books.Book_name AS BookTitle, Borrowing.BorrowDate, 'Returned' AS Status
FROM Borrowing
JOIN Books ON Borrowing.BookID = Books.BookID
WHERE Borrowing.ReturnDate IS NOT NULL;








