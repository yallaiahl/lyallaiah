#robotmcp
*** Settings ***
Library    ../UserLibrary.py

*** Variables ***
${PRODUCT}    wireless mouse

*** Test Cases ***
Add Product To Cart On Flipkart
    [Tags]    robotmcp
    ${res}=    Add Product To Cart Flipkart    ${PRODUCT}    True
    Log    ${res}
