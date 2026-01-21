*** Settings ***
Library    SeleniumLibrary
Library   BuiltIn
*** Variables ***
${number}    42
${float_number}    3.14
${big_number}    12345678901234567890
*** Test Cases ***
Check Integer Types
    Log    Integer: ${number}    LEVEL=INFO
    Log    Float: ${float_number}    LEVEL=INFO
    Log    Big Integer: ${big_number}    LEVEL=INFO
    Should Be Equal As Integers    ${number}    42
    Should Be Equal As Numbers     ${float_number}    3.14
    Should Be Equal As Integers    ${big_number}    12345678901234567890    