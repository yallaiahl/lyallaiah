*** Settings ***
Library    AppiumLibrary

*** Variables ***
${REMOTE}    http://localhost:4723/wd/hub
${PLATFORM}  Android
${DEVICE}    emulator-5554
${APP_PACKAGE}    com.example.myapp
${APP_ACTIVITY}   .MainActivity

*** Test Cases ***
Open App And Click
    [Documentation]    Opens the app and clicks a login button identified by accessibility id
    [Tags]    appium
    Open Application    ${REMOTE}    platformName=${PLATFORM}    deviceName=${DEVICE}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
    Wait Until Element Is Visible    accessibility_id=login_button    10s
    Click Element    accessibility_id=login_button
    [Teardown]    Close Application
