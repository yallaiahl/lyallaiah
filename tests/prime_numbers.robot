#robotmcp
*** Settings ***
Library    BuiltIn
Library    ../UserLibrary.py
Library    Collections

*** Test Cases ***
Generate Primes Up To 100
    [Tags]    robotmcp
    ${EXPECTED}=    Evaluate    [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]
    ${primes}=    Generate Primes Up To    100
    Lists Should Be Equal    ${primes}    ${EXPECTED}
    Log    ${primes}
