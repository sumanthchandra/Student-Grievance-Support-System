create schema grievance_support;

use grievance_support;

create table user (user_email varchar(40) primary key, user_password varchar(60), user_role varchar(15));

create table student (firstname varchar(30), lastname varchar(30), email varchar(40) primary key, password varchar(60), 
gender varchar(20), course varchar(60), year int, branch varchar(60), college varchar(60), university varchar(60), 
foreign key(email) references user(user_email));

create table members (jurisdiction varchar (15), mcollege varchar(60) default 'NA',
muniversity varchar(60), mfirstname varchar(30), mlastname varchar(30), memail varchar(40) primary key, mpassword varchar(60), mgender varchar(10),
foreign key(memail) references user(user_email));

create table ticket (ticket_id int auto_increment primary key, email_id varchar(40), name varchar(60), gender varchar(20), college varchar(60) default 'NA', 
university varchar(60), level varchar (10), keyword varchar(20),  subject varchar(50), urgency varchar(4), description varchar(200), 
anonymity varchar(10), ticket_date date, ticket_time time, status varchar(15) default 'OPENED', foreign key(email_id) references user(user_email)); 
alter table ticket auto_increment=100000;

create table feedback(id int auto_increment primary key, name varchar(60), email varchar(40), message varchar(200), reply_status varchar(20) default 'NOT_REPLIED');
alter table feedback auto_increment=100000;
insert into user values('Admin@GrievanceSupport','5efaa709c1c178c7f205dd93810d59ce7efe43e2','Admin');#Hello5