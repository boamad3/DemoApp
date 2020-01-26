*** Settings ***
Documentation  Register Page for New Users
Library  SeleniumLibrary

*** Variables ***
${FIRST_NAME_FIELD}=  id=firstname
${FAMILY_NAME_FIELD}=  id=lastname
${PHONE_NUMBER_FIELD}=  id=phone
${REGISTER_BUTTON}=  xpath=//html/body/section/form/input[6]

*** Keywords ***
Verify Register Page Loaded
    Wait Until Page Contains  Register

Enter Name
    Input Text  ${FIRST_NAME_FIELD}  ${FIRST_NAME}
    Input Text  ${FAMILY_NAME_FIELD}  ${FAMILY_NAME}

Enter Another Name
    Input Text  ${FIRST_NAME_FIELD}  Jonas
    Input Text  ${FAMILY_NAME_FIELD}  James

Enter Contact Details
    Input Text  ${PHONE_NUMBER_FIELD}  ${PHONE_NUMBER}

Submit Registration details
    Click Button  ${REGISTER_BUTTON}

Notify user that username is taken
    Wait Until Page Contains  User ${USERNAME} is already registered.

Prompt user to input missing data
    Page Should Contain Button  ${REGISTER_BUTTON}
    Log  Unable to process request due to internal prompt to enter credentials
