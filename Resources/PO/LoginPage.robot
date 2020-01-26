*** Settings ***
Documentation  Login Page for Users
Library  SeleniumLibrary

*** Variables ***
${USER_NAME_FIELD}=  id=username
${PASSWORD_FIELD}=  id=password
${LOG_IN_BUTTON}=  xpath=//html/body/section/form/input[3]


*** Keywords ***
Login Page Loaded
    Page Should Contain Element  ${LOG_IN_BUTTON}

Enter Username
    Input Text  ${USER_NAME_FIELD}  ${USERNAME}

Enter Password
    Input Text  ${PASSWORD_FIELD}  ${PASSWORD}

Submit user credentials
    Click button  ${LOG_IN_BUTTON}

Swap username and password
    Input Text  ${USER_NAME_FIELD}  ${PASSWORD}
    Input Text  ${PASSWORD_FIELD}  ${USERNAME}

New username and no password
    Input Text  ${USER_NAME_FIELD}  ${NEW_USERNAME}
    Input Text  ${PASSWORD_FIELD}  ${NO_PASSWORD}

Small case username and no password
    Input Text  ${USER_NAME_FIELD}  ${SMALL_CASE_USERNAME}
    Input Text  ${PASSWORD_FIELD}  ${NO_PASSWORD}

Prompt user to input missing data
    Wait Until Page Contains  Log In
    Log  Unable to process request due to internal prompt to enter credentials
