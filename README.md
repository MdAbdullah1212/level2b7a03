Question 1: What role does a Foreign Key play in the Bookings table, and how does it safeguard against entering a ticket sale for a match that doesn't exist?

 <!--?? উত্তর: -->
Bookings টেবিলে Foreign Key ব্যবহার করা হয় অন্য একটি টেবিলের সাথে সম্পর্ক স্থাপন করার জন্য। Football Ticket Booking System-এ সাধারণত Bookings টেবিলে match_id নামে একটি Foreign Key থাকে, যা Matches টেবিলের match_id (Primary Key)-এর সাথে যুক্ত থাকে।
এর প্রধান ভূমিকা হলো তথ্যের সঠিকতা বজায় রাখা।
যখন কোনো নতুন টিকিট বুকিং যোগ করা হয়, তখন Database চেক করে যে ওই match_id টি Matches টেবিলে আগে থেকেই আছে কিনা। যদি ম্যাচটি বিদ্যমান থাকে, তাহলে বুকিং তথ্য সংরক্ষণ হবে। কিন্তু যদি এমন কোনো match_id দেওয়া হয় যেটি Matches টেবিলে নেই, তাহলে Foreign Key Constraint সেই ডাটা গ্রহণ করবে না।

<!-- ========================================================= -->

