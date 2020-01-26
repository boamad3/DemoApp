*** Settings ***
Documentation  DemoApp MainPage
Library  SeleniumLibrary

*** Variables ***
${REGISTER_FORM_LINK}=  xpath=//html/body/nav/ul/li[1]/a
${LOG_IN_LINK}=  xpath=//html/body/nav/ul/li[2]/a
${DEMO_APP_LINK}=  xpath=//html/body/nav/h1/a
${USERNAME_IN_HEADER}=  xpath=//html/body/nav/ul/li[1]/span

*** Keywords ***
Demo App Link
    Click link  ${DEMO_APP_LINK}

Load
    Go To  ${START_URL}

Verify Page Loaded
    Wait Until Page Contains  index page

Load Registration Form
    Click link  ${REGISTER_FORM_LINK}

Load Log in Page
    Click link  ${LOG_IN_LINK}

Back to User Info
    Run Keyword And Ignore Error  Click Element  ${USERNAME_IN_HEADER}