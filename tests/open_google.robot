*** Settings ***
Library    SeleniumLibrary
Suite Setup    Open Browser To Google
Suite Teardown    Close All Browsers

*** Variables ***
${BROWSER}    chrome
${HEADLESS}    False

*** Test Cases ***
Open Google Test
    [Documentation]    Open Google homepage and verify search box is present
    Wait Until Element Is Visible    name:q    10s
    ${title}=    Get Title
    Log    Page title: ${title}

*** Keywords ***
Open Browser To Google
    [Arguments]    ${HEADLESS}=${HEADLESS}
    Run Keyword If    '${HEADLESS}'=='True'    Open Browser    https://www.google.com    ${BROWSER}    options=add_argument=--headless
    ...    ELSE    Open Browser    https://www.google.com    ${BROWSER}    options=add_argument=--start-maximized
