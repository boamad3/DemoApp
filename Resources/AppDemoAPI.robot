*** Settings ***
Library  RequestsLibrary
Library  Collections


*** Variables ***

*** Keywords ***
Begin Basic Authentication
    ${authenticate}=  create list  ${USERNAME}  ${PASSWORD}
	create session  basicSession  ${START_URL}    auth=${authenticate}
	${response}=  get request  basicSession  ${ROUTE_ONE}
	log  ${response.content}
    set test variable  ${response}

Create Headers
	${headers}  create dictionary  token=${responseToken}  Content-Type=${CONTENT_TYPE}
	set test variable  ${headers}

Create Header Without Token
	${headers}  create dictionary  Content-Type=${CONTENT_TYPE}
	set test variable  ${headers}

Create Header With Fake Token
	${headers}  create dictionary  token=${FAKE_TOKEN}  Content-Type=${CONTENT_TYPE}
	set test variable  ${headers}

Create Payload
	${payload}  create dictionary  firstname=Patrick  lastname=Enemy
	set test variable  ${payload}

Extract API Response Content from JSON Output
	${responseDict}  Evaluate  json.loads('''${response.content}''')  json
    set test variable  ${responseDict}

Extract Status
    ${responseStatus}  Get From Dictionary  ${responseDict}  status
    set test variable  ${responseStatus}

Extract Token
    ${responseToken}  Get From Dictionary  ${responseDict}  token
    set test variable  ${responseToken}

Extract Payload
	${responsePayload}  Get From Dictionary  ${responseDict}  payload
	log  ${responsePayload}
    set test variable  ${responsePayload}

Make Token Globally Available
    set global variable  ${responseToken}

Use Token to Access API for Reviewing Registered Users
    create session  Review  ${START_URL}
	${response}=  get request  Review  ${ROUTE_TWO}  headers=${headers}
	log  ${response.content}
	set test variable  ${response}

Use Token to Access API to Read Personal Data
    create session  dataView  ${START_URL}
	${response}=  get request  dataView  ${ROUTE_THREE}  headers=${headers}
	log  ${response.content}
	set test variable  ${response}

Use Token to Access API to Modify Personal Data
    create session  ModifyInfo  ${START_URL}
	${response}=  put request  ModifyInfo  ${ROUTE_THREE}  data=${payload}  headers=${headers}
	log  ${response.content}
	#should be equal as strings  ${response.status_code}  201
	set test variable  ${response}

Verify That User Data Exist
	list should contain value  ${responsePayload}  ${USERNAME}

Validate API Authentication
    should be equal  ${responseStatus}  SUCCESS

Validate Failed API Authentication
    ${failure_message}  create list  Token authentication required  Invalid Token
    ${responseMessage}  Get From Dictionary  ${responseDict}  message
	should contain  ${failure_message}  ${responseMessage}
    should be equal  ${responseStatus}  FAILURE

Verify That User Data Has Been Changed
    ${responseMessage}  Get From Dictionary  ${responseDict}  message
	should be equal  ${responseMessage}  Updated

