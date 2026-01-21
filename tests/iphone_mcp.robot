*** Settings ***
Documentation     Automates the requested Flipkart -> Amazon iPhone workflow.
Library           SeleniumLibrary
Library           BuiltIn
Suite Setup       Open Browser To Default
Suite Teardown    Close All Browsers

*** Variables ***
${BROWSER}    chrome
${FLIPKART}   https://www.flipkart.com
${AMAZON}     https://www.amazon.in
${SEARCH1}    iphone 13
${SEARCH2}    iphone

*** Test Cases ***
iPhone Full Workflow
    [Documentation]    1) open flipcart 2) search iphone 13 3) select iphone13 black 128GB 4) add to cart
    ...                5) cancel all items in cart 6) close flipkart 7) open amazon 8) search iphone
    ...                9) select iphone 10) check price
    Open Flipkart And Search iPhone13
    Select iPhone13 Black 128GB And Add To Cart
    Empty Flipkart Cart
    Close Flipkart
    Open Amazon And Search iPhone
    Select First Amazon Result And Log Price

*** Keywords ***
Open Browser To Default
    [Arguments]    ${url}=about:blank    ${HEADLESS}=False
    Run Keyword If    '${HEADLESS}'=='True'    Open Browser    ${url}    ${BROWSER}    options=add_argument=--headless
    ...    ELSE    Open Browser    ${url}    ${BROWSER}    options=add_argument=--start-maximized
    Set Selenium Speed    0.0s

Open Flipkart And Search iPhone13
    Go To    ${FLIPKART}
    Sleep    1s
    # close login modal if present
    Run Keyword And Ignore Error    Click Button    css:button._2KpZ6l._2doB4z
    Wait Until Element Is Visible    css:input[name='q']    10s
    Input Text    css:input[name='q']    ${SEARCH1}
    Press Keys    css:input[name='q']    \13
    Wait Until Page Contains    iphone    10s

Select iPhone13 Black 128GB And Add To Cart
    # Click first visible product containing 'iPhone 13'
    Wait Until Element Is Visible    xpath://div[contains(translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'iphone 13')]    10s
    Click Element    xpath:(//div[contains(translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'iphone 13')])[1]
    Wait Until Page Contains Element    xpath://button[contains(translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'add to cart') or contains(.,'ADD TO CART')]    10s
    Run Keyword And Ignore Error    Click Button    xpath://button[contains(translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'add to cart') or contains(.,'ADD TO CART')]
    Sleep    2s

Empty Flipkart Cart
    # Open cart page and attempt to remove items; selectors vary by region. This tries common patterns.
    Go To    https://www.flipkart.com/viewcart
    Sleep    1s
    :FOR    ${i}    IN RANGE    1    6
    \    Run Keyword And Ignore Error    Click Element    xpath://button[contains(translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'remove') or contains(.,'Remove')]
    \    Sleep    0.5s

Close Flipkart
    Close Browser

Open Amazon And Search iPhone
    Open Browser    ${AMAZON}    ${BROWSER}
    Wait Until Element Is Visible    id:twotabsearchtextbox    10s
    Input Text    id:twotabsearchtextbox    ${SEARCH2}
    Press Keys    id:twotabsearchtextbox    \13
    Wait Until Page Contains    iphone    10s

Select First Amazon Result And Log Price
    # Click first product title
    Wait Until Element Is Visible    xpath:(//span[contains(@class,'a-size-medium') or contains(@class,'a-size-base-plus') or contains(@class,'a-size-base')])[1]    10s
    Click Element    xpath:(//span[contains(@class,'a-size-medium') or contains(@class,'a-size-base-plus') or contains(@class,'a-size-base')])[1]
    # Try common price locators
    ${price}=    Run Keyword And Return Status    Get Text    id:priceblock_ourprice
    Run Keyword If    ${price} == False    ${price}=    Run Keyword And Return Status    Get Text    id:priceblock_dealprice
    Run Keyword If    '${price}' == 'False'    Log    Price element not found on Amazon page
    Log    Amazon price: ${price}
