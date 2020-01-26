*** Settings ***
Documentation  User Information Page
Library  SeleniumLibrary

*** Variables ***
${LOG_OUT_LINK}=  xpath=//html/body/nav/ul/li[2]/a

*** Keywords ***
Verify User Data Page Did Not Load
    Wait Until Page Contains  Login Failure

Verify User Data Page Loaded
    Wait Until Page Contains  User Information
    Page Should Contain Element  id=content

Logout
    Click link  ${LOG_OUT_LINK}

