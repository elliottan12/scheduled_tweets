#  The Model View Controller (MVC) Pattern

GET /about HTTP/1.1
Host: 127.0.0.1

## Routes
Matchers for the URL that is requested. 
GET for "/about" 
I see you requested "/about", we'll give that to the AboutController to handle. 

## Models
Database wrapper 

User 
* query for records
* wrap individual records and give things like validation like username has to be at least 3 characters long. 

## Views
Your response body content 
* HTML 
* CSV 
* PDF
* XML 
This is what gets sent back to your browser and displayed. 

## Controllers
Decide how to process a request and define a response. 
Controllers decide where things go. For example, if your password is too short, it will ask you to re-enter your password. If it is the correct length, it can redirect you to your homepage. 