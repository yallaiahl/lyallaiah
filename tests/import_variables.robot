*** Comments ***
# importing variables from an external Python file

*** Settings ***
Variables    ../src/robotmcp_libs/variables.py    
*** Test Cases ***
Import Variables Test
    Log    Value of x: ${x}    
    Log    Value of y: ${y}    
    Log    Value of z: ${z}    
    Should Be Equal As Integers    ${x}    10
    Should Be Equal As Integers    ${y}    20
    Should Be Equal As Integers    ${z}    30
log list items
    Log   List item 1: ${my_list[0]}    
    Log    List item 2: ${my_list[1]}    
    Log    List item 3: ${my_list[2]}    
    Log    List item 4: ${my_list[3]}    
    Log    List item 5: ${my_list[4]}    
    Should Be Equal As Integers    ${my_list[0]}    1
    Should Be Equal As Integers    ${my_list[1]}    2
    Should Be Equal As Integers    ${my_list[2]}    3
    Should Be Equal As Integers    ${my_list[3]}    4
    Should Be Equal As Integers    ${my_list[4]}    5