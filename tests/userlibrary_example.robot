*** Settings ***
Library    robotmcp_libs.userlibrary.UserLibrary

*** Test Cases ***
Echo Keyword Works
    ${msg}=    Echo    Hello Robot
    Should Be Equal    ${msg}    Hello Robot

Add Numbers Works
    ${sum}=    Add Numbers    2    3
    Should Be Equal As Numbers    ${sum}    5

Multiply Numbers Default
    ${prod}=    Multiply Numbers    4
    Should Be Equal As Numbers    ${prod}    4

Multiply Numbers Two Args
    ${prod2}=    Multiply Numbers    4    2
    Should Be Equal As Numbers    ${prod2}    8
