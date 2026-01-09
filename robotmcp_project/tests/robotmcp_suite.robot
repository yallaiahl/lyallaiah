*** Settings ***
Documentation    RobotMCP example suite (tagged with robotmcp)
Resource    ../resources/keywords.robot

*** Test Cases ***
Greeting Test
    [Tags]    robotmcp
    Log Greeting
    Should Be True    ${TRUE}

Simple Log Test
    [Tags]    robotmcp
    Log    This is a RobotMCP CI test
    Length Should Be    Hello    5
