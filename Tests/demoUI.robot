*** Settings ***
Documentation    UI Testing of the Web portal
Resource  ../Resources/DemoApp.robot  #Necessary for lower level keywords in test
Resource  ../Resources/Common.robot  #Necessary for test setup and teardown

Test Setup  Begin Web Test
Test Teardown  End Web Test

*** Variables ***
${BROWSER} =  ie
${START_URL} =  http://localhost:8080       #Address to Application may vary
${USERNAME} =  Dave23
${PASSWORD} =  power
${FIRST_NAME}=  David
${FAMILY_NAME}=  Smith
${PHONE_NUMBER}=  +1 111 444 5555
${NEW_USERNAME}=  DAVE24
${SMALL_CASE_USERNAME}=  dave24
${NO_PASSWORD}=  ${SPACE}
${LOG_IN_BUTTON}=  xpath=//html/body/section/form/input[3]

*** Test Cases ***
TC1_The main page of the app should be displayed
    [Tags]    Smoke
    DemoApp.Show main page

TC2_The user registeration form should load
    [Tags]  SmokeReg
    DemoApp.Show main page
    DemoApp.Show registration page

TC3_The user Log in page should load
    [Tags]  SmokeLogin
    DemoApp.Show main page
    DemoApp.Show Log in page
    DemoApp.Verify Log in page

TC4_The user should not be able to log in without credentials
    [Tags]  NoEntry
    DemoApp.Show main page
    DemoApp.Show Log in page
    DemoApp.Log in with credentials
    DemoApp.Verify Log in page

TC5_The user should not be able log in without registration
    [Tags]  UnregisteredUser
    [Documentation]  Assumes the database does not contain given username
    DemoApp.Show main page
    DemoApp.Show Log in page
    DemoApp.Enter username and password
    DemoApp.Submit log in details

TC6_The user should be able to register a new account
    [Tags]  Registration
    [Documentation]  This is where the user is registered for the first time
    DemoApp.Show main page
    DemoApp.Show registration page
    DemoApp.Enter username and password
    DemoApp.Register first and last name
    DemoApp.Register phone number
    DemoApp.Send Registration details
    DemoApp.Verify Log in page

TC7_A registered user should be able to access personal data
    [Tags]  RegisteredUser
    [Documentation]  The registered user from TC6 can now log in
    DemoApp.Show main page
    DemoApp.Show Log in page
    DemoApp.Verify Log in page
    DemoApp.Enter username and password
    DemoApp.Log in with credentials
    DemoApp.Show user information

TC8_A registered user should be able to log out
    [Tags]  LogOut
    [Documentation]  Requires a registered user. Run  TC6 in case it hasn't already run
    DemoApp.Show main page
    DemoApp.Show Log in page
    DemoApp.Enter username and password
    DemoApp.Log in with credentials
    DemoApp.Show user information
    DemoApp.Log out of user data page
    DemoApp.Show main page

TC9_The user should not be able to register an account with existing username
    [Tags]  UsernameTaken
    DemoApp.Show main page
    DemoApp.Show registration page
    DemoApp.Enter username and password
    DemoApp.Register first and last name
    DemoApp.Register phone number
    DemoApp.Send Registration details
    DemoApp.Username already exist

TC10_The user should not be able to swap username and password entry
    [Tags]  Confusion
    DemoApp.Show main page
    DemoApp.Show Log in page
    DemoApp.Enter wrong username and password
    DemoApp.Submit log in details

TC11_The user should be able to register an account without password
    [Tags]  NoPassword
    DemoApp.Show main page
    DemoApp.Show registration page
    DemoApp.Enter new username and no password
    DemoApp.Register first and last name
    DemoApp.Register phone number
    DemoApp.Send Registration details
    DemoApp.Verify Log in page
    DemoApp.Enter new username and no password
    DemoApp.Log in with credentials
    DemoApp.Show user information

TC12_The user should be able to create an account with existing username
    [Tags]  CaseSensitive
    DemoApp.Show main page
    DemoApp.Show registration page
    DemoApp.Enter small-case-username and no password
    DemoApp.Enter a new name for the account
    DemoApp.Register phone number
    DemoApp.Send Registration details
    DemoApp.Verify Log in page
    DemoApp.Enter small-case-username and no password
    DemoApp.Log in with credentials
    DemoApp.Show user information
    DemoApp.Compare names on the two similar accounts

TC19_The user should be able to return to the main page with Demo App
    [Tags]  goHome
    DemoApp.Show main page
    DemoApp.Show registration page
    DemoApp.Go home with Demo App Link
    DemoApp.Verify Main Page

TC20_Logged in user should be able to return to user info
    [Documentation]  A user should be registered before running this test. Run TC6 to register a user
    [Tags]  StayHome
    DemoApp.Show main page
    DemoApp.Show Log in page
    DemoApp.Verify Log in page
    DemoApp.Enter username and password
    DemoApp.Log in with credentials
    DemoApp.Show user information
    DemoApp.Go home with Demo App Link
    DemoApp.Verify Main Page
    DemoApp.Click on username in header
    DemoApp.Show user information
    Log  There is no element to return user back to information page
