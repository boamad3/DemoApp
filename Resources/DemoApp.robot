*** Settings ***
Resource  ../Resources/PO/LandingPage.robot
Resource  ../Resources/PO/RegisterForm.robot
Resource  ../Resources/PO/LoginPage.robot
Resource  ../Resources/PO/UserData.robot


*** Keywords ***
Click on username in header
    LandingPage.Back to User Info

Compare names on the two similar accounts
    Page Should Contain  Jonas
    Should Not Be Equal As Strings  ${FIRST_NAME}  Jonas

Enter username and password
    LoginPage.Enter Username
    LoginPage.Enter Password

Enter wrong username and password
    LoginPage.Swap username and password

Enter new username and no password
    LoginPage.New username and no password

Enter small-case-username and no password
    LoginPage.Small case username and no password

Enter a new name for the account
    RegisterForm.Enter Another Name

Go home with Demo App Link
    LandingPage.Demo App Link

Log in with credentials
    LoginPage.Submit user credentials

Log out of user data page
    UserData.Logout

Prompt user of failed Login
    LoginPage.Prompt user to input missing data

Prompt user of failed registration
    RegisterForm.Prompt user to input missing data

Register first and last name
    RegisterForm.Enter Name

Register phone number
    RegisterForm.Enter Contact Details

Show main page
    LandingPage.Load
    LandingPage.Verify Page Loaded

Show registration page
    LandingPage.Load Registration Form
    RegisterForm.Verify Register Page Loaded

Send registration details
    RegisterForm.Submit Registration details

Show user information
    UserData.Verify User Data Page Loaded

Show Log in page
    LandingPage.Load Log in Page

Submit log in details
    LoginPage.Submit user credentials
    UserData.Verify User Data Page Did Not Load

Username already exist
    RegisterForm.Notify user that username is taken

Verify Log in page
    LoginPage.Login Page Loaded

Verify Main Page
    LandingPage.Verify Page Loaded














