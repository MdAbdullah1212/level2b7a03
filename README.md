<!-- ?? ERD google drive links -->

https://drive.google.com/file/d/1uJ9UY9WwJVFYAi7c2Suk1V6G5sQhUnh8/view?usp=sharing

Question 1: What role does a Foreign Key play in the Bookings table, and how does it safeguard against entering a ticket sale for a match that doesn't exist?

Answer:
Bookings টেবিলে Foreign Key ব্যবহার করা হয় অন্য একটি টেবিলের সাথে সম্পর্ক স্থাপন করার জন্য। Football Ticket Booking System-এ সাধারণত Bookings টেবিলে match_id নামে একটি Foreign Key থাকে, যা Matches টেবিলের match_id (Primary Key)-এর সাথে যুক্ত থাকে।
এর প্রধান ভূমিকা হলো তথ্যের সঠিকতা বজায় রাখা।
যখন কোনো নতুন টিকিট বুকিং যোগ করা হয়, তখন Database চেক করে যে ওই match_id টি Matches টেবিলে আগে থেকেই আছে কিনা। যদি ম্যাচটি বিদ্যমান থাকে, তাহলে বুকিং তথ্য সংরক্ষণ হবে। কিন্তু যদি এমন কোনো match_id দেওয়া হয় যেটি Matches টেবিলে নেই, তাহলে Foreign Key Constraint সেই ডাটা গ্রহণ করবে না।

<!-- ========================================================= -->

Question 3: If a Primary Key column guarantees that all row entries are completely unique, why does the database system also explicitly forbid it from containing a NULL value?

Answer :
Primary Key শুধু “unique” না—এটা প্রতিটা রো এর real identity নিশ্চিত করে। তাই NULL allowed না।
Primary Key NULL allowed না কারণ,
NULL মানে unknown identity,
Primary Key entity identify করে,
relationships এবং indexing ভেঙে যায়
uniqueness NULL-এর সাথে reliableভাবে enforce করা যায় না

<!-- ============================================================= -->

Question 5: What is the difference between a main query and a subquery? In what scenarios would you choose to use a subquery over a standard JOIN operation?

Answer :
Main query হলো outer query, যেটা final result return করে।
Subquery হলো একটা query-এর ভিতরে আরেকটা query।
JOIN ব্যবহার করতে multiple table data একসাথে fetch করতে হয়।
