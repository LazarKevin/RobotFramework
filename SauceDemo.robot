*** Settings ***
Library    Selenium2Library

*** Test Cases ***
Open saucedemo webpage
    Open Browser    https://www.saucedemo.com/    Chrome
    


Login with valid credentials
    Open Browser    https://www.saucedemo.com/    Chrome
    #Input Text    //*[@id="user-name"]    standard_user
    Input Text    id:user-name    standard_user
    Input Password   id:password    secret_sauce
    Click Button    id:login-button
    Page Should Contain Element   //*[@id="shopping_cart_container"]/a
    Close All Browsers
    # Open Browser  https://www.aaha.org/wp-content/uploads/2024/09/kitten-lying-in-blanket.jpg    Chrome

Login with standard_user wrong password
    Open Browser    https://www.saucedemo.com/    Chrome
    Input Text    id:user-name    standard_user
    Input Password   id:password    wrong_password
    Click Button    id:login-button
    Page Should Contain    Username and password do not match any user in this service
    Close Browser

Login with wrong username and valid password
    Open Browser    https://www.saucedemo.com/    Chrome
    Input Text    id:user-name    wrong_user
    Input Password   id:password    secret_sauce
    Click Button    id:login-button
    Page Should Contain    Username and password do not match any user in this service
    Close Browser

Login without username
    Open Browser    https://www.saucedemo.com/    Chrome
    Input Password   id:password    secret_sauce
    Click Button    id:login-button
    Page Should Contain    Username is required
    Close Browser

Login without password
    Open Browser    https://www.saucedemo.com/    Chrome
    Input Text    id:user-name    standard_user
    Click Button    id:login-button
    Page Should Contain    Password is required
    Close Browser

Buy product and complete checkout
    Open Browser    https://www.saucedemo.com/    Firefox
    Input Text    id:user-name    standard_user
    Input Password    id:password    secret_sauce
    Click Button    id:login-button
    Click Button     //*[@id="add-to-cart-sauce-labs-backpack"]
    Click Element     id:shopping_cart_container
    Click Button    id:checkout
    Input Text    id:first-name    ASD
    Input Text    id:last-name    ASD
    Input Text    id:postal-code    6767
    Click Button    id:continue
    Click Element    //*[@id="finish"]
    Page Should Contain    Thank you for your order!
    Close Browser