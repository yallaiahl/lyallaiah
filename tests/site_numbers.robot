*** Settings ***
Library    robotmcp_libs.site_checker.SiteChecker
Library    BuiltIn

*** Test Cases ***
Site Contains Numbers 1 To 10
    [Tags]    site    day1
    ${nums}=    Get Numbers From Page    http://127.0.0.1:8000
    Log    ${nums}
    Assert Numbers 1 To 10 Present    ${nums}
