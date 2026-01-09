#robotmcp
*** Settings ***
Library    BuiltIn
Library    ../UserLibrary.py

*** Test Cases ***
First Test
    [Tags]    robotmcp
    ${greeting}=    Hello User    Alice
    Log    ${greeting}
