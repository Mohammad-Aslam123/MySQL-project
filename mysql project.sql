create database library;
use library;
create table branch(branch_no int primary key auto_increment,manager_id int,branch_address varchar(20),contact_no varchar(10))auto_increment=1;
create table employee(emp_id int primary key,emp_name varchar(20),position varchar(20),salary int,branch_no int, foreign key (branch_no)references branch(branch_no));
create table customer(customer_id int primary key auto_increment,customer_name varchar(20),customer_address varchar(20),reg_date date)auto_increment=1001;
create table books(isbn bigint primary key,book_title varchar(30),category varchar(20),rental_price decimal(10,2),status varchar(10),author varchar(30),publisher varchar(20));

create table issuestatus (issue_id int primary key,issued_cust int,issued_book_name varchar(30),issued_date date,isbn_book bigint,
foreign key(issued_cust)references customer(customer_id),foreign key(isbn_book)references books(isbn));

create table returnstatus(return_id int primary key,return_cust int,book_name varchar(30),return_date date, isbn_book2 bigint,
foreign key (return_cust)references customer(customer_id),foreign key (isbn_book2)references books(isbn));
                                
               
insert into branch (manager_id,branch_address,contact_no)values (101,'calicut',9745545540),
                         (102,'manjeri',9214888111),
                         (103,'tirur',9948436221);

insert into employee values (140,'reshma','librarian',60000,2),
							(141,'salim','librarian',70000,3),
                            (142,'haris','library assistant',30000,2),
                            (143,'asna','library clerk',20000,2),
                            (144,'hashir','librarian',45000,1),
                            (145,'arjn','library assistant',40000,3);
                            
insert into customer (customer_name,customer_address,reg_date)values                            
									('shihan','vailathur','2020-03-22'),
                                    ('safa','tirur','2020-10-28'),
                                    ('john','kondotty','2020-11-03'),
                                    ('abhi','calicut','2021-04-08'),
                                    ('fidha','calicut','2021-11-12'),
                                    ('martin','perinthalmanna','2022-02-19'),
                                    ('rima','manjeri','2023-02-01'),
                                    ('afsal','malappuram','2023-04-12');
                                    
insert into books values(8171300243,'premalekhanam','romance',310,'yes','vaikkom muhammed basheer','dc books'),
						(9944510281,'deivathinte charanmar','real story',230,'yes','joseph annamkutty joseph','dc books'),
                        (0443377450,'rich dad poor dad','finance',450,'no','robert kiyoski','warner books'),
                        (97887264755568,'ram c\o anandi','novel',349,'yes','akhi p dharmajam','penguin books'),
                        (9780143416333,'goat days','true story',430,'yes','bennyamin','dc books');

insert into issuestatus values(11,1004,'goat days','2024-02-01',9780143416333),
							(12,1006,'deivathinte charanmar','2023-05-11',9944510281),
                            (13,1002,'premalekhanam','2023-05-12',8171300243),
                            (14,1001,'goat days','2023-05-15',9780143416333),
                            (15,1007,'ram c/o anandi','2023-05-28',97887264755568),
                            (16,1004,'premalekhanam','2023-06-10',8171300243);

insert into returnstatus values(901,1004,'goat days','2023-06-02',9780143416333),
								(902,1006,'deivathinte charanmar','2023-06-13',9944510281),
                                 (903,1002,'premalekhanam','2023-06-15',8171300243),
                                 (904,1001,'goat days','2023-06-18',9780143416333),
                                 (905,1007,'ram c/o anandi','2023-06-30',97887264755568);

select*from customer;   
select*from books;     
select*from employee;         
select*from branch;
select*from issuestatus;
select*from returnstatus;
        
#1. Retrieve the book title, category, and rental price of all available books.
select book_title,category,rental_price from books where status ='yes';

#2. List the employee names and their respective salaries in descending order of salary.	
select emp_name,salary from employee order by salary desc;

#3. Retrieve the book titles and the corresponding customers who have issued those books.
select 	issuestatus.issued_cust,issuestatus.issued_book_name,customer.customer_name from issuestatus inner join customer on issuestatus.issued_cust=customer.customer_id;			

#4. Display the total count of books in each category.
select category,count(isbn)as count_category from books group by category;

#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000
select emp_name,position,salary from employee where salary>50000;

#6. List the customer names who registered before 2022-01-01 and have not issued any books yet
select customer_name,reg_date from customer where reg_date<'2022-01-01' and customer_id not in (select issued_cust from issuestatus);

#7. Display the branch numbers and the total count of employees in each branch.
select branch_no,count(branch_no)as count_of_branch from employee group by branch_no;

#8. Display the names of customers who have issued books in the month of June 2023.
select issued_cust from issuestatus where issued_date>='2023-06-01'and issued_date<='2023-06-30'  in (select customer_name from customer) ;

#9. Retrieve book_title from book table containing history. 
select book_title from books where category='history';

#10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
select branch_no,count(branch_no)as count_of_employees from employee group by branch_no having count(branch_no)>5;