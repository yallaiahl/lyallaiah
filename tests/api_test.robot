#robotmcp
*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Suite Setup    Skip Api If Offline

*** Variables ***
${BASE}    https://httpbin.org

*** Test Cases ***
Get Request Returns 200 And Has URL
    [Tags]    robotmcp    api
    Create Session    httpbin    ${BASE}
    ${resp}=    Get Request    httpbin    /get
    Should Be Equal As Integers    ${resp.status_code}    200
    ${json}=    To Json    ${resp}
    Should Be Equal    ${json['url']}    ${BASE}/get

Post Request Echoes Data
    [Tags]    robotmcp    api
    Create Session    httpbin    ${BASE}
    ${payload}=    Create Dictionary    foo=bar    num=42
    ${resp}=    Post Request    httpbin    /post    json=${payload}
    Should Be Equal As Integers    ${resp.status_code}    200
    ${json}=    To Json    ${resp}
    Should Be Equal    ${json['json']['foo']}    bar
    Should Be Equal As Integers    ${json['json']['num']}    42

*** Keywords ***
Skip Api If Offline
    Skip If    '%{CI=false}'.lower() in ('1','true')    API tests skipped in CI/offline environments

To Json
    [Arguments]    ${content}
    ${call_result}=    Run Keyword And Ignore Error    Call Method    ${content}    json
    Run Keyword If    "${call_result[0]}" == "PASS"    Return From Keyword    ${call_result[1]}
    ${is_dict}=    Evaluate    isinstance(${content}, dict)
    Run Keyword If    ${is_dict}    Return From Keyword    ${content}
    ${text}=    Convert To String    ${content}
    ${json}=    Evaluate    __import__('json').loads(${text})
    RETURN    ${json}
