*** Settings ***
Resource  ../Resources/AppDemoAPI.robot


*** Variables ***
${BROWSER}  ie
${START_URL}  http://localhost:8078
${USERNAME}  Dave23
${PASSWORD}  power
${ROUTE_ONE}  /api/auth/token
${ROUTE_TWO}  /api/users
${ROUTE_THREE}  /api/users/${USERNAME}
${CONTENT_TYPE}  application/json
${FAKE_TOKEN}  NzQxOTMxNDExMTE4MjY4MIg4NTMxMDQ4NTg1OTc2MjA4MjQyMzI=

*** Test Cases ***
TC13_Gain access to API and generate authentcation token
	[Tags]  GenToken
	[Documentation]  A valid user account should exist before running this. Create one with TC6 or manualy
    AppDemoAPI.Begin Basic Authentication
    AppDemoAPI.Extract API Response Content from JSON Output
    AppDemoAPI.Extract Status
    AppDemoAPI.Validate API Authentication
    AppDemoAPI.Extract Token
    AppDemoAPI.Make Token Globally Available

TC14_Review users registered in the system
	[Tags]  ReviewUsers
    AppDemoAPI.Create Headers
    AppDemoAPI.Use Token to Access API for Reviewing Registered Users
    AppDemoAPI.Extract API Response Content from JSON Output
    AppDemoAPI.Extract Status
    AppDemoAPI.Validate API Authentication
    AppDemoAPI.Extract Payload
    AppDemoAPI.Verify That User Data Exist

TC15_User should be able to get personal data when authenticated
	[Tags]  UserInfo
	AppDemoAPI.Create Headers
	AppDemoAPI.Use Token to Access API to Read Personal Data
    AppDemoAPI.Extract API Response Content from JSON Output
    AppDemoAPI.Extract Status
	AppDemoAPI.Validate API Authentication

TC16_User should be able to modify personal data when authenticated
	[Tags]  UserMod
	AppDemoAPI.Create Headers
	AppDemoAPI.Create Payload
	AppDemoAPI.Use Token to Access API to Modify Personal Data
	AppDemoAPI.Extract API Response Content from JSON Output
	AppDemoAPI.Extract Status
	AppDemoAPI.Verify That User Data Has Been Changed
	AppDemoAPI.Validate API Authentication

TC17_User should not be able to access personal data without Token
	[Tags]  NoToken
	AppDemoAPI.Create Header Without Token
    AppDemoAPI.Use Token to Access API to Read Personal Data
    AppDemoAPI.Extract API Response Content from JSON Output
    AppDemoAPI.Extract Status
	AppDemoAPI.Validate Failed API Authentication

TC18_User should not be able to modify personal data without Token
	[Tags]  Restricted
	AppDemoAPI.Create Header Without Token
	AppDemoAPI.Create Payload
	AppDemoAPI.Use Token to Access API to Modify Personal Data
	AppDemoAPI.Extract API Response Content from JSON Output
	AppDemoAPI.Extract Status
	AppDemoAPI.Validate Failed API Authentication

TC21_User should not be able to access personal data with Fake Token
	[Tags]  FakeToken
	AppDemoAPI.Create Header With Fake Token
    AppDemoAPI.Use Token to Access API to Read Personal Data
    AppDemoAPI.Extract API Response Content from JSON Output
    AppDemoAPI.Extract Status
	AppDemoAPI.Validate Failed API Authentication