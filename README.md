# Overview

"This is a personal project where I designed a 16-bit CPU with a set of 25 instructions introduced in M. Morris Mano's book, Computer System Architecture, using Verilog."

# Purpose of this project

"I created this project to deepen my understanding of computer architecture, digital logic circuits, and Verilog HDL."

# More Detail

"I wanted to try both behavioral and dataflow modeling in Verilog, so I applied behavioral modeling to large-scale modules like the system bus, while using dataflow modeling for smaller modules like register modules, where I derived Boolean functions from block diagrams, truth tables, and Karnaugh maps."

**Class:** Dog vs Specialty Dog

**Breed:** Each dog will belong to a specific breed

**Groups:** Breeds are collected into groups  
&nbsp; &nbsp; Group 1, Sporting Dogs <br />
&nbsp; &nbsp; Group 2, Hounds <br />
&nbsp; &nbsp; Group 3, Working Dogs <br />
&nbsp; &nbsp; Group 4, Terriers <br />
&nbsp; &nbsp; Group 5, Toys <br />
&nbsp; &nbsp; Group 6, Non-Sporting  <br />
&nbsp; &nbsp; Group 7, Herding <br />

# Functionalities:

**1. Add dog information:**  
&nbsp; &nbsp; * Entry Number (Auto generated and unique) <br />
&nbsp; &nbsp; * Name <br />
&nbsp; &nbsp; * Owner name <br />
&nbsp; &nbsp; * Breed <br />
&nbsp; &nbsp; * Group (Must be one of the 7 groups listed) <br />
&nbsp; &nbsp; * Gender (Male/Female) <br />
&nbsp; &nbsp; * Class or Specialty <br />

**2.  Edit and Delete:**  
    Be able to edit and delete dogs from the dog show

**3. Email:**  
    Add an email to the dog registration page.  When someone registers their dog, send an email to the email address entered that confirms that they added their dog successfully in the body of the email, and provide all of the details they entered in the body of the email also.

**4. Dog Handlers:**  
    Sometimes dog owners will hire handlers to show their dogs for them.  Create Tomcat security for your website.  Your users will be dog handlers.  When a dog handler logs in they should be able to add and view dogs in a personal list for themselves (The dogs they will show).   The entire web application is not under security, only the pages relevant to the dog handler.

**5. Add Shows:**  
    Dog shows will usually occur in groups over a weekend.  
    Choose 3 days over a Friday-Sunday in March of 2019 to host the dog show.  When a dog is registered, they should be able to choose one, two, or three shows to attend.  When showing the dogs, include what days the dogs will be attending.  Note:  When a dog is registered, they keep the same number during all 3 shows.  It would not be making different numbers for each day.

**6. Display Individual Shows:**  
    It is able to select which of your 3 days to display.  Format the output so that it has the date of the show at the top of the page, and the page is nicely formatted to print.

**7. Handlers:**  
    If you are logged in as a handler, be able to select one of the 3 days and show the dogs that are registered for that day to show.


**The website works best in Chrome.
## How to run:  
Use the following credentials to log in:  

Handler Name: Kyle
Password: notReal

To make dummy dogs:
 
Click "Register" to go to the register page (Day 1) which also has a "Create Dummy" button.

Add the following roles to your tomcat-users.xml file on the server:

