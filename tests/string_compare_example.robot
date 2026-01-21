*** Settings ***
Library    ../src/robotmcp_libs/string_compare.py

*** Test Cases ***
Compare equal strings
    ${res}=    Compare Strings    Hello    Hello
    Should Be True    ${res}

Compare case-insensitive
    ${res}=    Compare Strings    Hello    hello    False
    Should Be True    ${res}

Assert equal (keyword)
    Assert Strings Equal    foo    foo
