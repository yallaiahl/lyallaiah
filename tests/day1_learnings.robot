*** Settings ***
Library    robotmcp_libs.string_compare.StringCompare
Library    BuiltIn
Suite Setup    Log    Starting day1_learnings suite

*** Variables ***
${GREETING}    Hello, Robot MCP

*** Test Cases ***
Log And Check Greeting
    [Tags]    day1    RobotMCP
    Log    ${GREETING}
    Should Be Equal    ${GREETING}    Hello, Robot MCP

Compare Strings Equal
    [Tags]    day1    RobotMCP
    Compare Strings    abc    abc
    Assert Strings Equal    abc    abc

Compare Strings Case Insensitive
    [Tags]    day1    RobotMCP
    Compare Strings    Hello    hello    case_sensitive=False
    Assert Strings Equal    Hello    hello    case_sensitive=False

Expected Failure Example
    [Tags]    day1
    Run Keyword And Expect Error    *Strings not equal*    Assert Strings Equal    a    b
